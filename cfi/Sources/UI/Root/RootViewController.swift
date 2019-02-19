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
    private let userService: UserService?

    private var username: String?
    private var profilePicture: UIImage? = nil
    private var useDefaultProfilePicture = false

    private var mainView: RootView {
        return self.view as! RootView
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    init() {
        self.userService = UserService(for: Authentification.shared.getToken())
        super.init(nibName: nil, bundle: nil)

        if let service = self.userService {
            service.getUsername { username in
                self.username = username
                self.configureSubviews()
            }

            service.getProfilePicture { profilePicture in
                if let picture = profilePicture {
                    self.profilePicture = picture
                } else {
                    self.useDefaultProfilePicture = true
                }

                self.configureSubviews()
            }
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        self.view = RootView()
        self.mainView.delegate = self
    }

    private func configureSubviews() {
        guard let username = self.username else { return }

        if self.profilePicture != nil || self.useDefaultProfilePicture {
            self.mainView.configure(name: username, profileImage: self.profilePicture)
        }
    }

    func didRequestTransition(to viewController: UIViewController) {
        self.present(viewController, animated: true)
    }
}
