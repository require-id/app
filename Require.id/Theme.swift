// Require.id 2019

import UIKit
import Whisper

protocol Theme {
    var navigationBarTintColor: UIColor? { get }
    var navigationBarBackgroundColor: UIColor? { get }
}

struct DefaultTheme { }

extension DefaultTheme: Theme {
    var navigationBarTintColor: UIColor? { return UIColor.gingerbread }
    var navigationBarBackgroundColor: UIColor? { return UIColor.blueberry }
}

final class ThemeRegistry {
    static func applyTheme(theme: Theme) {
        let navigationBarAppearance = UINavigationBar.appearance()
        navigationBarAppearance.tintColor = theme.navigationBarTintColor
        if let tintColor = theme.navigationBarTintColor {
            navigationBarAppearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor: tintColor]
        }

        navigationBarAppearance.barTintColor = theme.navigationBarBackgroundColor
        navigationBarAppearance.isTranslucent = false
        navigationBarAppearance.shadowImage = UIImage()


        let tableViewAppearance = UITableView.appearance()
        tableViewAppearance.backgroundColor = .blueberry
        tableViewAppearance.separatorColor = .blueberry
        tableViewAppearance.tintColor = .gingerbread

        let titleCellAppearance = TitleCell.appearance()
        titleCellAppearance.backgroundColor = UIColor.blueberry
        titleCellAppearance.tintColor = UIColor.gingerbread

        let tabBarAppearance = UITabBar.appearance()
        tabBarAppearance.tintColor = .gingerbread
        tabBarAppearance.backgroundColor = .blueberry
        tabBarAppearance.barTintColor = .blueberry

        let progressViewAppearance = UIProgressView.appearance()
        progressViewAppearance.trackTintColor = .currant
        progressViewAppearance.tintColor = .fizz
    }
}
