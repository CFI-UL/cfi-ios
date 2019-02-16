//
//  AuthViewController.swift
//  cfi
//
//  Created by Alexandre Frigon on 2019-02-15.
//  Copyright © 2019 Frigstudio. All rights reserved.
//

import UIKit
import SafariServices

class AuthViewController: BaseViewController, AuthViewDelegate {
    private var mainView: AuthView {
        return self.view as! AuthView
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    init() {
        super.init(nibName: nil, bundle: nil)
        self.title = "Login"
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        self.view = AuthView()
        self.mainView.delegate = self
    }

    func didInitiateLogin() {
        let safariViewController = SFSafariViewController(url: Authentification.authorizationURL)
        self.navigationController?.present(safariViewController, animated: true, completion: nil)
    }
}
