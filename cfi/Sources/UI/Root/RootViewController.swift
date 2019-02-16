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

class RootViewController: BaseViewController, RootViewDelegate {
    private var mainView: RootView {
        return self.view as! RootView
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    init() {
        super.init(nibName: nil, bundle: nil)
        self.title = "CFI"
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        self.view = RootView()
        self.mainView.delegate = self
    }

    func didOpenDoor() {
        DoorService.sendRequest(callback: { error in
            if let error = error {
                if error.statusCode == .unauthorized {
                    Authentification.shared.clearToken()
                    self.navigationController?.present(NavigationController(rootViewController: AuthViewController()), animated: true, completion: nil)
                    return
                }

                let alertViewController = UIAlertController(title: "Error", message: "Could not open the door (\(error.statusCode.rawValue))", preferredStyle: .alert)
                alertViewController.addAction(UIAlertAction(title: "ok", style: .default, handler: nil))

                self.navigationController?.present(alertViewController, animated: true, completion: nil)
            }
        })
    }
}
