//
//    MIT License
//
//    Copyright (c) 2019 Alexandre Frigon
//
//    Permission is hereby granted, free of charge, to any person obtaining a copy
//    of this software and associated documentation files (the "Software"), to deal
//    in the Software without restriction, including without limitation the rights
//    to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//    copies of the Software, and to permit persons to whom the Software is
//    furnished to do so, subject to the following conditions:
//
//    The above copyright notice and this permission notice shall be included in all
//    copies or substantial portions of the Software.
//
//    THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//    IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//    FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//    AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//    LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//    OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//    SOFTWARE.
//

import UIKit

protocol QuickActionsDelegate: class {
    func quickActions(quickActions: QuickActions, didOpenDoor: Bool)
}

enum QuickActionType: String {
    case openDoor = "OpenDoorAction"
}

class QuickActions {
    weak var delegate: QuickActionsDelegate?
    let command: QuickActionType

    static let openDoorShortcutItem = UIApplicationShortcutItem(type: QuickActionType.openDoor.rawValue,
                                                                localizedTitle: "Open the door",
                                                                localizedSubtitle: "",
                                                                icon: UIApplicationShortcutIcon(type: .home),
                                                                userInfo: nil)

    init(_ command: String, delegate: QuickActionsDelegate) {
        self.command = QuickActionType(rawValue: command)!
        self.delegate = delegate
    }

    func process(_ userInfo: [String: NSSecureCoding]? = nil) {
        switch self.command {
        case .openDoor: self.delegate?.quickActions(quickActions: self, didOpenDoor: true)
        }
    }

    static func generateActions() -> [UIApplicationShortcutItem] {
        var shortcuts: [UIApplicationShortcutItem] = []

        if Authentification.shared.isAuthentificated() {
            shortcuts.append(QuickActions.openDoorShortcutItem)
        }

        return shortcuts
    }
}
