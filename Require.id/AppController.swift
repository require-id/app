import UIKit

final class AppController {

    private var shouldShowAuth = false
    private var window: UIWindow?

    func appDidFinishLaunching(with window: UIWindow?) {
//        self.window = window
//        var viewController: UIViewController
//        if shouldShowAuth {
//            viewController = AuthViewController(appController: self)
//        } else {
//            viewController = navigationController
//        }

        //window?.rootViewController = viewController
        //window?.makeKeyAndVisible()
    }

    // MARK: - API

    func didAuthenticate() {
        // window?.rootViewController = navigationController
    }

    func didTapOpenSettings() {
        let settingsController = AppController.makeNavigationController(with: SettingsViewController(appController: self))
        if #available(iOS 13.0, *) {
            settingsController.modalPresentationStyle = .automatic
        }
        // navigationController.present(settingsController, animated: true)
    }

    func didTapOpenToken(viewModel: TokenViewModel) {
    }

    // MARK: - Private

    private static func makeNavigationController(with root: UIViewController) -> UINavigationController {
        return UINavigationController(rootViewController: root)
    }
}
