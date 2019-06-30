//
//  UINavigationControllerExtensions.swift
//  Require.id
//
//  Created by Emil Bogren on 2019-06-29.
//  Copyright © 2019 Emil Bogren. All rights reserved.
//

import Foundation
import UIKit

extension UINavigationController {

    open override var preferredStatusBarStyle: UIStatusBarStyle {
        return topViewController?.preferredStatusBarStyle ?? .default
    }
}
