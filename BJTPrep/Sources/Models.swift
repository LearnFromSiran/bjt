import Foundation

enum Category: String, CaseIterable, Codable, Identifiable {
    case keigo = "Keigo"
    case vocabulary = "Business Vocab"
    case email = "Email & Phrases"
    case etiquette = "Workplace Etiquette"

    var id: String { rawValue }
    var icon: String {
        switch self {
        case .keigo: return "person.2.fill"
        case .vocabulary: return "briefcase.fill"
        case .email: return "envelope.fill"
        case .etiquette: return "building.2.fill"
        }
    }
}

struct Card: Identifiable, Hashable {
    let id: String
    let japanese: String
    let reading: String
    let english: String
    let example: String
    let exampleEnglish: String
    let category: Category
}

struct Question: Identifiable, Hashable {
    let id: String
    let prompt: String
    let choices: [String]
    let answer: Int
    let explanation: String
    let category: Category
}

struct Stats: Codable {
    var answered = 0
    var correct = 0
    var streak = 0
    var lastStudyDay: Date?
    var perCategory: [String: [Int]] = [:] // [correct, total]
    var dailyCount = 0
    var dailyDay: Date?
}

struct CardState: Codable {
    var box = 0
    var due = Date.distantPast
}
