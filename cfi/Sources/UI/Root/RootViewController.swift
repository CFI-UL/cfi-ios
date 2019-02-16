//
//  ViewController.swift
//  cfi
//
//  Created by Alexandre Frigon on 2019-02-10.
//  Copyright © 2019 Frigstudio. All rights reserved.
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
        Request("\(Config.apiHost)/door/request", method: .post).auth().send()
    }
}
