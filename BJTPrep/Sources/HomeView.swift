import SwiftUI

struct HomeView: View {
    @EnvironmentObject var store: Store
    @State private var showSettings = false

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 16) {
                    HStack(spacing: 16) {
                        StatTile(title: "Streak", value: "\(store.stats.streak)", systemImage: "flame.fill", color: .orange)
                        StatTile(title: "Accuracy", value: "\(Int(store.accuracy * 100))%", systemImage: "target", color: .green)
                    }

                    VStack(alignment: .leading, spacing: 10) {
                        Text("Daily goal").font(.headline)
                        ProgressView(value: store.dailyProgress)
                            .tint(.accentColor)
                        Text("\(store.stats.dailyCount) / \(store.dailyGoal) items today")
                            .font(.subheadline).foregroundStyle(.secondary)
                    }
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(.thinMaterial, in: RoundedRectangle(cornerRadius: 16))

                    VStack(alignment: .leading, spacing: 8) {
                        Text("Phrase of the day").font(.headline)
                        let card = phraseOfTheDay
                        Text(card.japanese).font(.largeTitle.bold())
                        Text(card.reading).foregroundStyle(.secondary)
                        Text(card.english)
                        Divider()
                        Text(card.example)
                        Text(card.exampleEnglish).font(.footnote).foregroundStyle(.secondary)
                    }
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(.thinMaterial, in: RoundedRectangle(cornerRadius: 16))

                    Text("\(store.dueCards().count) flashcards due for review")
                        .font(.subheadline).foregroundStyle(.secondary)
                }
                .padding()
            }
            .navigationTitle("BJT Prep")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button { showSettings = true } label: { Image(systemName: "gearshape") }
                        .accessibilityLabel("Settings")
                }
            }
            .sheet(isPresented: $showSettings) { SettingsView() }
        }
    }

    private var phraseOfTheDay: Card {
        let day = Calendar.current.ordinality(of: .day, in: .era, for: Date()) ?? 0
        return Content.cards[day % Content.cards.count]
    }
}

struct StatTile: View {
    let title: String
    let value: String
    let systemImage: String
    let color: Color

    var body: some View {
        VStack(spacing: 6) {
            Image(systemName: systemImage).font(.title2).foregroundStyle(color)
            Text(value).font(.title.bold())
            Text(title).font(.caption).foregroundStyle(.secondary)
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(.thinMaterial, in: RoundedRectangle(cornerRadius: 16))
        .accessibilityElement(children: .combine)
    }
}
