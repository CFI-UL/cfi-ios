//
//  AppDelegate.swift
//  cfi
//
//  Created by Alexandre Frigon on 2019-02-10.
//  Copyright © 2019 Frigstudio. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, AuthentificationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        Stylesheet.appearance()

        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window!.backgroundColor = .white
        self.window!.tintColor = .primary

        Authentification.shared.clearToken()

        self.window!.rootViewController = NavigationController(rootViewController:
            Authentification.shared.isAuthentificated() ?
                RootViewController() :
                AuthViewController())

        //print(Authentification.shared.getToken())

        self.window!.makeKeyAndVisible()

        return true
    }

    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        guard let components = NSURLComponents(url: url, resolvingAgainstBaseURL: true),
            let command = components.host else {
                print("Invalid URL")
                return false
        }

        CFIScheme(command, delegate: self).process(components.queryItems)
        return true
    }

    func didAuthenticate() {
        let viewController = NavigationController(rootViewController: RootViewController())
        self.window?.rootViewController?.dismiss(animated: true, completion: {
            self.window?.rootViewController?.present(viewController, animated: true, completion: nil)
        })
    }

    func didCancelAuthentification() {
        self.window?.rootViewController?.dismiss(animated: true, completion: {
            let alertViewController = UIAlertController(title: "Error", message: "Could not sign in with slack", preferredStyle: .alert)
            alertViewController.addAction(UIAlertAction(title: "ok", style: .default, handler: nil))

            self.window?.rootViewController?.present(alertViewController, animated: true, completion: nil)
        })




    }
}

