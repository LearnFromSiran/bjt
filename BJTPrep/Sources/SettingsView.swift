import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var store: Store
    @Environment(\.dismiss) private var dismiss
    @State private var confirmReset = false

    var body: some View {
        NavigationStack {
            Form {
                Section("Daily goal") {
                    Stepper("\(store.dailyGoal) items per day", value: $store.dailyGoal, in: 5...50, step: 5)
                }
                Section("Privacy") {
                    Text("BJT Prep stores your progress only on this device. It collects no personal data and has no ads or tracking.")
                        .font(.footnote)
                }
                Section {
                    Button("Reset all progress", role: .destructive) { confirmReset = true }
                }
                Section {
                    HStack { Text("Version"); Spacer(); Text(Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "1.0").foregroundStyle(.secondary) }
                }
            }
            .navigationTitle("Settings")
            .toolbar { ToolbarItem(placement: .confirmationAction) { Button("Done") { dismiss() } } }
            .confirmationDialog("Erase all progress?", isPresented: $confirmReset, titleVisibility: .visible) {
                Button("Reset", role: .destructive) { store.resetAll() }
            }
        }
    }
}
