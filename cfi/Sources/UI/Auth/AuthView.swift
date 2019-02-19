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
import PinLayout

protocol AuthViewDelegate: class {
    func didInitiateLogin()
    func didInitiateJoin()
}

class AuthView: UIView {
    weak var delegate: AuthViewDelegate?

    private let titleLabel = TitleLabel(text: "Sign in")
    private let featureView = FeatureView(icon: #imageLiteral(resourceName: "icon-id"), description: "You'll need to join the Slack to use the app")

    private let loginButton = UIButton()
    private let joinSlackButton = UIButton()

    init() {
        super.init(frame: .zero)
        self.backgroundColor = .primary

        self.addSubview(self.titleLabel)
        self.addSubview(self.featureView)
        self.addSubview(self.loginButton)
        self.addSubview(self.joinSlackButton)

        self.loginButton.setImage(#imageLiteral(resourceName: "SlackLogin"), for: .normal)
        self.loginButton.imageView?.contentMode = .scaleAspectFit
        self.loginButton.addTarget(self, action: #selector(self.login), for: .touchUpInside)

        self.joinSlackButton.titleLabel?.font = UIFont.apercu(ofSize: 16)
        self.joinSlackButton.setTitleColor(.translucentWhite, for: .normal)
        self.joinSlackButton.setTitleColor(UIColor.translucentWhite.alterOpacity(by: -0.3), for: .highlighted)
        self.joinSlackButton.setTitle("Join the Slack", for: .normal)
        self.joinSlackButton.addTarget(self, action: #selector(self.join), for: .touchUpInside)
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        self.titleLabel.pin.top(160).left(50).right(50).sizeToFit()
        self.featureView.pin.below(of: self.titleLabel, aligned: .start).marginTop(50)

        self.loginButton.pin.below(of: self.featureView).height(45).width(90%).hCenter().marginTop(200)
        self.joinSlackButton.pin.bottom(50).hCenter().sizeToFit()
    }

    @objc func login(_ sender: Any) { self.delegate?.didInitiateLogin() }
    @objc func join(_ sender: Any) { self.delegate?.didInitiateJoin() }
}
