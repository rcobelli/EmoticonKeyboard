import SwiftUI
import UIKit

final class AppDelegate: NSObject, UIApplicationDelegate {
    func application(
        _ application: UIApplication,
        performActionFor shortcutItem: UIApplicationShortcutItem,
        completionHandler: @escaping (Bool) -> Void
    ) {
        guard let settingsURL = URL(string: UIApplication.openSettingsURLString) else {
            completionHandler(false)
            return
        }

        application.open(settingsURL, options: [:], completionHandler: completionHandler)
    }
}

@main
struct EmoticonKeyboardApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) private var appDelegate
    @Environment(\.scenePhase) private var scenePhase

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .onChange(of: scenePhase) { _, _ in }
    }
}
