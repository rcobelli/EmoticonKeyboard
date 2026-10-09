import SwiftUI
import UIKit

struct ContentView: View {
    var body: some View {
        TabView {
            NavigationStack {
                InstallationInstructionsView()
            }
            .tabItem {
                Label("Installation", systemImage: "info.circle")
            }

            NavigationStack {
                EmoticonListView()
            }
            .tabItem {
                Label("Emoticon List", systemImage: "list.bullet")
            }
        }
        .tint(.primary)
    }
}

private struct InstallationInstructionsView: View {
    private let isTesting = CommandLine.arguments.contains("testing")
    @State private var testInput = ""
    
    
    private let steps = [
        "Settings",
        "General",
        "Keyboard",
        "Keyboards",
        "Add New Keyboard...",
        "Emoticon Keyboard"
    ]

    var body: some View {
        List {
            Section {
                ForEach(steps, id: \.self) { step in
                    if step == steps.first {
                        Button {
                            openSettings()
                        } label: {
                            HStack {
                                Text(step).fontWeight(.semibold)
                                Spacer()
                                Image(systemName: "chevron.right")
                                    .font(.footnote.weight(.semibold))
                                    .foregroundStyle(.tertiary)
                            }
                        }
                        .foregroundStyle(.blue)
                    } else {
                        Text(step)
                    }
                }
            } header: {
                Text("To enable the keyboard:")
            }
            
            if isTesting {
                TextField("UI Testing Keyboard", text: $testInput)
                    .accessibilityIdentifier("keyboardTestField")
            }
        }
        .navigationTitle("Installation Instructions")
    }

    private func openSettings() {
        guard let settingsURL = URL(string: UIApplication.openSettingsURLString) else {
            return
        }

        UIApplication.shared.open(settingsURL)
    }
}
