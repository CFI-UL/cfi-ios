//
//  AuthView.swift
//  cfi
//
//  Created by Alexandre Frigon on 2019-02-15.
//  Copyright © 2019 Frigstudio. All rights reserved.
//

import UIKit
import PinLayout

protocol AuthViewDelegate: class {
    func didInitiateLogin()
}

class AuthView: UIView {
    weak var delegate: AuthViewDelegate?

    private let loginButton = UIButton()
    private let logo = UIImageView()

    init() {
        super.init(frame: .zero)

        self.addSubview(self.loginButton)
        self.addSubview(self.logo)

        self.backgroundColor = .white

        self.logo.image = #imageLiteral(resourceName: "LogoCFI")

        self.loginButton.setImage(#imageLiteral(resourceName: "SlackLogin"), for: .normal)
        self.loginButton.addTarget(self, action: #selector(self.login), for: .touchUpInside)
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        self.logo.pin.width(50%).maxWidth(300).aspectRatio().center().marginTop(-48)
        self.loginButton.pin.below(of: self.logo).height(75).width(90%).maxWidth(300).hCenter().marginTop(48)
    }

    @objc func login(sender: Any) {
        self.delegate?.didInitiateLogin()
    }
}
