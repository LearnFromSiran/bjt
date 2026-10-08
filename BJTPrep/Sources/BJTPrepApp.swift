import SwiftUI

@main
struct BJTPrepApp: App {
    @StateObject private var store = Store()

    var body: some Scene {
        WindowGroup {
            RootView()
                .environmentObject(store)
        }
    }
}

struct RootView: View {
    var body: some View {
        TabView {
            HomeView()
                .tabItem { Label("Today", systemImage: "house.fill") }
            QuizHubView()
                .tabItem { Label("Quiz", systemImage: "checkmark.circle.fill") }
            FlashcardsView()
                .tabItem { Label("Cards", systemImage: "rectangle.on.rectangle.angled") }
            ProgressTabView()
                .tabItem { Label("Progress", systemImage: "chart.bar.fill") }
        }
    }
}
