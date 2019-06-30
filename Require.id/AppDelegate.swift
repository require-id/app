// Require.id 2019

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    private let appController = AppController()

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        // Theme
        let defaultTheme = DefaultTheme()
        ThemeRegistry.applyTheme(theme: defaultTheme)

        // Set initial controller
        appController.appDidFinishLaunching(with: window)

        return true
    }
}

