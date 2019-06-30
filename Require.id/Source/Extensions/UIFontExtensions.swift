//
//  UIFontExtensions.swift
//  Require.id
//
//  Created by Emil Bogren on 2019-06-29.
//  Copyright © 2019 Emil Bogren. All rights reserved.
//

import Foundation
import UIKit

func getScaledFont(forFont name: String, textStyle: UIFont.TextStyle) -> UIFont {
    let userFont =  UIFontDescriptor.preferredFontDescriptor(withTextStyle: textStyle)
    let pointSize = userFont.pointSize
    guard let customFont = UIFont(name: name, size: pointSize) else {
        fatalError("""
            Failed to load the "\(name)" font.
            Make sure the font file is included in the project and the font name is spelled correctly.
            """
        )
    }
    return UIFontMetrics.default.scaledFont(for: customFont)
}


extension UIFont {
    static var cellTitle: UIFont { return getScaledFont(forFont: "Menlo-Regular", textStyle: .headline) }
    static var cellSubtitle: UIFont { return getScaledFont(forFont: "Menlo-Regular", textStyle: .subheadline) }
    static var subheadline: UIFont { return getScaledFont(forFont: "Menlo-Regular", textStyle: .subheadline) }

    static var cellLarge: UIFont { return getScaledFont(forFont: "Menlo-Bold", textStyle: .title1) }
    static var title1: UIFont { return getScaledFont(forFont: "Menlo-Bold", textStyle: .title1) }

    static var settingSectionTitle: UIFont { return getScaledFont(forFont: "Menlo-Bold", textStyle: .subheadline) }

}
