import SwiftUI

struct QuizHubView: View {
    var body: some View {
        NavigationStack {
            List {
                Section("Practice by topic") {
                    NavigationLink { QuizSessionView(category: nil) } label: {
                        Label("Mixed quiz", systemImage: "shuffle")
                    }
                    ForEach(Category.allCases) { cat in
                        NavigationLink { QuizSessionView(category: cat) } label: {
                            Label(cat.rawValue, systemImage: cat.icon)
                        }
                    }
                }
            }
            .navigationTitle("Quiz")
        }
    }
}

struct QuizSessionView: View {
    @EnvironmentObject var store: Store
    let category: Category?

    @State private var questions: [Question] = []
    @State private var index = 0
    @State private var selected: Int?
    @State private var score = 0
    @State private var finished = false

    var body: some View {
        Group {
            if finished {
                VStack(spacing: 16) {
                    Image(systemName: "star.fill").font(.system(size: 56)).foregroundStyle(.yellow)
                    Text("\(score) / \(questions.count)").font(.largeTitle.bold())
                    Text(score == questions.count ? "Perfect!" : "Nice work — keep going.")
                        .foregroundStyle(.secondary)
                    Button("Try again") { start() }.buttonStyle(.borderedProminent)
                }
            } else if index < questions.count {
                let q = questions[index]
                ScrollView {
                    VStack(alignment: .leading, spacing: 16) {
                        ProgressView(value: Double(index), total: Double(questions.count))
                        Text("Question \(index + 1) of \(questions.count)")
                            .font(.caption).foregroundStyle(.secondary)
                        Text(q.prompt).font(.title3.weight(.semibold))
                        ForEach(q.choices.indices, id: \.self) { i in
                            Button { choose(i, q) } label: {
                                HStack {
                                    Text(q.choices[i]).multilineTextAlignment(.leading)
                                    Spacer()
                                    if let s = selected {
                                        if i == q.answer { Image(systemName: "checkmark.circle.fill").foregroundStyle(.green) }
                                        else if i == s { Image(systemName: "xmark.circle.fill").foregroundStyle(.red) }
                                    }
                                }
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(color(for: i, q), in: RoundedRectangle(cornerRadius: 12))
                            }
                            .buttonStyle(.plain)
                            .disabled(selected != nil)
                        }
                        if selected != nil {
                            Text(q.explanation).font(.callout)
                                .padding()
                                .background(.thinMaterial, in: RoundedRectangle(cornerRadius: 12))
                            Button(index + 1 == questions.count ? "Finish" : "Next") { next() }
                                .buttonStyle(.borderedProminent)
                                .frame(maxWidth: .infinity)
                        }
                    }
                    .padding()
                }
            } else {
                Text("No questions available.").foregroundStyle(.secondary)
            }
        }
        .navigationTitle(category?.rawValue ?? "Mixed quiz")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear { if questions.isEmpty { start() } }
    }

    private func color(for i: Int, _ q: Question) -> Color {
        guard let s = selected else { return Color(.secondarySystemBackground) }
        if i == q.answer { return .green.opacity(0.2) }
        if i == s { return .red.opacity(0.2) }
        return Color(.secondarySystemBackground)
    }

    private func start() {
        let pool = Content.questions.filter { category == nil || $0.category == category }
        questions = Array(pool.shuffled().prefix(10))
        index = 0; score = 0; selected = nil; finished = false
    }

    private func choose(_ i: Int, _ q: Question) {
        selected = i
        let ok = i == q.answer
        if ok { score += 1 }
        store.recordAnswer(category: q.category, correct: ok)
    }

    private func next() {
        selected = nil
        if index + 1 >= questions.count { finished = true } else { index += 1 }
    }
}
