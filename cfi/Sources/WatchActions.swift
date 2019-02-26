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

import WatchConnectivity

protocol WatchActionsDelegate: class {
    func watchActions(watchActions: WatchActions, didCheckAuth: Bool)
    func watchActions(watchActions: WatchActions, didOpenDoor: Bool)
}

public enum WatchActionType: String {
    case checkAuth = "CheckAuth"
    case openDoor = "OpenDoor"
}

class WatchActions {
    weak var delegate: WatchActionsDelegate?
    let command: WatchActionType

    init(_ command: String, delegate: WatchActionsDelegate) {
        self.command = WatchActionType(rawValue: command)!
        self.delegate = delegate
    }

    func process(_ data: [String: Any]? = nil) {
        switch self.command {
        case .checkAuth: self.delegate?.watchActions(watchActions: self, didCheckAuth: true)
        case .openDoor: self.delegate?.watchActions(watchActions: self, didOpenDoor: true)
        }
    }
}
