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

enum ViewControllerType {
    case root, events, contests, projects, photos, sesame, auth
}

class ViewControllerFactory {
    func rootViewController() -> BaseViewController {
        return self.assign(RootViewController())
    }

    func sesameViewController(shouldSendRequest: Bool = false) -> BaseViewController {
        return self.assign(SesameViewController(shouldSendRequest: shouldSendRequest))
    }

    func authViewController() -> BaseViewController {
        return self.assign(AuthViewController())
    }

    func firstViewController(auth authenticated: Bool = false) -> BaseViewController {
        return authenticated ? self.rootViewController() : self.authViewController()
    }

    func generate(from type: ViewControllerType) -> BaseViewController {
        switch type {
        case .root: return self.rootViewController()
        case .events: return self.rootViewController()
        case .contests: return self.rootViewController()
        case .projects: return self.rootViewController()
        case .photos: return self.rootViewController()
        case .sesame: return self.sesameViewController()
        case .auth: return self.authViewController()
        }
    }
}

extension ViewControllerFactory {
    fileprivate func assign(_ viewController: BaseViewController) -> BaseViewController {
        viewController.viewControllerFactory = self
        return viewController
    }
}
