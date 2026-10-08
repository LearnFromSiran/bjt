import SwiftUI

struct FlashcardsView: View {
    @EnvironmentObject var store: Store
    @State private var deck: [Card] = []
    @State private var flipped = false
    @State private var filter: Category?
    @State private var loaded = false

    var body: some View {
        NavigationStack {
            VStack(spacing: 16) {
                Picker("Category", selection: $filter) {
                    Text("All").tag(Category?.none)
                    ForEach(Category.allCases) { Text($0.rawValue).tag(Category?.some($0)) }
                }
                .pickerStyle(.menu)

                if let card = deck.first {
                    Text("\(deck.count) due").font(.caption).foregroundStyle(.secondary)
                    VStack(spacing: 12) {
                        if flipped {
                            Text(card.english).font(.title2.bold()).multilineTextAlignment(.center)
                            Divider()
                            Text(card.example)
                            Text(card.exampleEnglish).font(.footnote).foregroundStyle(.secondary)
                        } else {
                            Text(card.japanese).font(.system(size: 40, weight: .bold)).multilineTextAlignment(.center)
                            Text(card.reading).foregroundStyle(.secondary)
                        }
                    }
                    .padding()
                    .frame(maxWidth: .infinity, minHeight: 260)
                    .background(.thinMaterial, in: RoundedRectangle(cornerRadius: 20))
                    .onTapGesture { withAnimation { flipped.toggle() } }
                    .accessibilityAddTraits(.isButton)
                    .accessibilityHint("Double tap to flip")

                    if flipped {
                        HStack(spacing: 16) {
                            Button { answer(card, knew: false) } label: {
                                Label("Again", systemImage: "arrow.counterclockwise").frame(maxWidth: .infinity)
                            }.buttonStyle(.bordered).tint(.red)
                            Button { answer(card, knew: true) } label: {
                                Label("Got it", systemImage: "checkmark").frame(maxWidth: .infinity)
                            }.buttonStyle(.borderedProminent).tint(.green)
                        }
                    } else {
                        Text("Tap the card to reveal the answer").font(.footnote).foregroundStyle(.secondary)
                    }
                } else {
                    Spacer()
                    Image(systemName: "checkmark.seal.fill").font(.system(size: 56)).foregroundStyle(.green)
                    Text("All caught up!").font(.title2.bold())
                    Text("Come back later for your next review.").foregroundStyle(.secondary)
                    Spacer()
                }
                Spacer(minLength: 0)
            }
            .padding()
            .navigationTitle("Flashcards")
            .onAppear { if !loaded { reload(); loaded = true } }
            .onChange(of: filter) { _ in reload() }
        }
    }

    private func reload() { deck = store.dueCards(in: filter); flipped = false }

    private func answer(_ card: Card, knew: Bool) {
        store.review(card, knew: knew)
        flipped = false
        deck.removeFirst()
        if !knew { deck.append(card) }
    }
}
