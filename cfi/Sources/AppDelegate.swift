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
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    private let viewControllerFactory = ViewControllerFactory()
    private var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        Stylesheet.appearance()

        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window!.backgroundColor = .white
        self.window!.tintColor = .primary

        if !Config.preserveSession { Authentification.shared.clearToken() }

        if let shortcutItem = launchOptions?[UIApplication.LaunchOptionsKey.shortcutItem] as? UIApplicationShortcutItem {
            QuickActions(shortcutItem.type, delegate: self).process(shortcutItem.userInfo)
        } else {
            self.window!.rootViewController = self.viewControllerFactory.firstViewController(auth: Authentification.shared.isAuthentificated())
        }

        self.window!.makeKeyAndVisible()

        //self.setupNotification()

        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        application.shortcutItems = QuickActions.generateActions()
    }

    /// Handle request made to url starting with cfi://
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        guard let components = NSURLComponents(url: url, resolvingAgainstBaseURL: true),
            let command = components.host else {
                print("Invalid URL")
                return false
        }

        CFIScheme(command, delegate: self).process(components.queryItems)
        return true
    }

    private func setupNotification() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.badge, .alert, .sound]) { (granted, error) in
            guard error == nil && granted else { return }

            UNUserNotificationCenter.current().getNotificationSettings { settings in
                guard settings.authorizationStatus == .authorized else { return }

                DispatchQueue.main.async {
                    UIApplication.shared.registerForRemoteNotifications()
                }
            }
        }
    }

    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        // let token = deviceToken.map { data in String(format: "%02.2hhx", data) }.joined()
        // POST token to server
    }
}

extension AppDelegate: AuthentificationDelegate {
    func didAuthenticate() {
        self.window?.rootViewController?.dismiss(animated: true, completion: {
            self.window?.rootViewController?.present(self.viewControllerFactory.rootViewController(), animated: true)
        })
    }

    func didCancelAuthentification() {
        self.window?.rootViewController?.dismiss(animated: true, completion: {
            let alertViewController = UIAlertController(title: "Error", message: "Could not sign in with slack", preferredStyle: .alert)
            alertViewController.addAction(UIAlertAction(title: "ok", style: .default))

            self.window?.rootViewController?.present(alertViewController, animated: true)
        })
    }
}

extension AppDelegate: QuickActionsDelegate {
    func didOpenDoor() {
        self.window?.rootViewController = self.viewControllerFactory.sesameViewController(shouldSendRequest: true)
    }
}
