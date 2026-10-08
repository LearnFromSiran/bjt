import SwiftUI

struct ProgressTabView: View {
    @EnvironmentObject var store: Store

    var body: some View {
        NavigationStack {
            List {
                Section("Overall") {
                    row("Questions answered", "\(store.stats.answered)")
                    row("Accuracy", "\(Int(store.accuracy * 100))%")
                    row("Current streak", "\(store.stats.streak) days")
                    row("Cards mastered", "\(store.mastered()) / \(Content.cards.count)")
                }
                Section("By topic") {
                    ForEach(Category.allCases) { cat in
                        VStack(alignment: .leading, spacing: 6) {
                            HStack {
                                Label(cat.rawValue, systemImage: cat.icon)
                                Spacer()
                                Text(store.accuracy(for: cat).map { "\(Int($0 * 100))%" } ?? "—")
                                    .foregroundStyle(.secondary)
                            }
                            ProgressView(value: store.accuracy(for: cat) ?? 0).tint(.accentColor)
                        }
                        .padding(.vertical, 4)
                    }
                }
            }
            .navigationTitle("Progress")
        }
    }

    private func row(_ title: String, _ value: String) -> some View {
        HStack { Text(title); Spacer(); Text(value).foregroundStyle(.secondary) }
    }
}
