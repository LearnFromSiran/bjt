import Foundation
import SwiftUI

@MainActor
final class Store: ObservableObject {
    @Published private(set) var stats = Stats()
    @Published private(set) var states: [String: CardState] = [:]
    @AppStorage("dailyGoal") var dailyGoal = 10

    private let statsKey = "bjt.stats.v1"
    private let statesKey = "bjt.states.v1"
    private let defaults = UserDefaults.standard
    private static let intervals = [0, 1, 2, 4, 8, 16] // days per Leitner box

    init() {
        if let d = defaults.data(forKey: statsKey), let s = try? JSONDecoder().decode(Stats.self, from: d) { stats = s }
        if let d = defaults.data(forKey: statesKey), let s = try? JSONDecoder().decode([String: CardState].self, from: d) { states = s }
        rolloverDay()
    }

    private func save() {
        if let d = try? JSONEncoder().encode(stats) { defaults.set(d, forKey: statsKey) }
        if let d = try? JSONEncoder().encode(states) { defaults.set(d, forKey: statesKey) }
    }

    private func rolloverDay() {
        let cal = Calendar.current
        let today = cal.startOfDay(for: Date())
        if stats.dailyDay != today { stats.dailyDay = today; stats.dailyCount = 0 }
        if let last = stats.lastStudyDay, let gap = cal.dateComponents([.day], from: last, to: today).day, gap > 1 {
            stats.streak = 0
        }
    }

    private func markStudied() {
        let cal = Calendar.current
        let today = cal.startOfDay(for: Date())
        rolloverDay()
        if stats.lastStudyDay != today {
            stats.streak += 1
            stats.lastStudyDay = today
        }
        stats.dailyCount += 1
    }

    var accuracy: Double { stats.answered == 0 ? 0 : Double(stats.correct) / Double(stats.answered) }
    var dailyProgress: Double { min(1, Double(stats.dailyCount) / Double(max(1, dailyGoal))) }

    func accuracy(for c: Category) -> Double? {
        guard let v = stats.perCategory[c.rawValue], v[1] > 0 else { return nil }
        return Double(v[0]) / Double(v[1])
    }

    func recordAnswer(category: Category, correct: Bool) {
        stats.answered += 1
        if correct { stats.correct += 1 }
        var v = stats.perCategory[category.rawValue] ?? [0, 0]
        v[1] += 1
        if correct { v[0] += 1 }
        stats.perCategory[category.rawValue] = v
        markStudied()
        save()
    }

    // MARK: Flashcards (Leitner)

    func dueCards(in category: Category? = nil) -> [Card] {
        let now = Date()
        return Content.cards
            .filter { category == nil || $0.category == category }
            .filter { (states[$0.id]?.due ?? .distantPast) <= now }
            .shuffled()
    }

    func mastered(in category: Category? = nil) -> Int {
        Content.cards.filter { (category == nil || $0.category == category) && (states[$0.id]?.box ?? 0) >= 4 }.count
    }

    func review(_ card: Card, knew: Bool) {
        var s = states[card.id] ?? CardState()
        s.box = knew ? min(Self.intervals.count - 1, s.box + 1) : 0
        let days = Self.intervals[s.box]
        s.due = knew ? (Calendar.current.date(byAdding: .day, value: days, to: Date()) ?? Date()) : Date().addingTimeInterval(60)
        states[card.id] = s
        markStudied()
        save()
    }

    func resetAll() {
        stats = Stats()
        states = [:]
        defaults.removeObject(forKey: statsKey)
        defaults.removeObject(forKey: statesKey)
    }
}
