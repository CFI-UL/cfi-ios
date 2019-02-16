//
//  Stylesheet.swift
//  cfi
//
//  Created by Alexandre Frigon on 2019-02-10.
//  Copyright © 2019 Frigstudio. All rights reserved.
//

import UIKit

class Stylesheet {
    static func appearance() {
        UINavigationBar.appearance().barTintColor = .primary
        //UINavigationBar.appearance().isTranslucent = false
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.white]
    }
}

extension UIColor {
    class var primary: UIColor { return UIColor(hex: 0xE56765) }
    class var lightGrey: UIColor { return UIColor(hex: 0xB2B2B2) }

}
