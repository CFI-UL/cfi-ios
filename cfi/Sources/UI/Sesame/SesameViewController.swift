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

import IntentsUI
import UIKit

class SesameViewController: BaseViewController, SesameViewDelegate {
    private var mainView: SesameView {
        return self.view as! SesameView
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    init(shouldSendRequest: Bool = false) {
        super.init(nibName: nil, bundle: nil)
        if shouldSendRequest { self.didOpenDoor() }
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func loadView() {
        self.view = SesameView()
        self.mainView.delegate = self
    }

    func didOpenDoor() {
        DoorService.sendRequest(callback: { error in
            if let error = error {
                switch error.statusCode {
                case .unauthorized:
                    Authentification.shared.clearToken()
                    self.present(NavigationController(rootViewController: AuthViewController()), animated: true, completion: nil)
                case .tooManyRequest:
                    let alertViewController = UIAlertController(title: "Request pending", message: "A request is already waiting for approval", preferredStyle: .alert)
                    alertViewController.addAction(UIAlertAction(title: "ok", style: .default, handler: nil))

                    self.present(alertViewController, animated: true, completion: nil)
                default:
                    let alertViewController = UIAlertController(title: "Error", message: "Could not open the door (\(error.statusCode.rawValue))", preferredStyle: .alert)
                    alertViewController.addAction(UIAlertAction(title: "ok", style: .default, handler: nil))

                    self.present(alertViewController, animated: true, completion: nil)
                }
            }
        })
    }

    func didAddToSiri() {
        let intent = OpenDoorIntent()
        intent.suggestedInvocationPhrase = "Open the CFI door"

        guard let shortcut = INShortcut(intent: intent) else { return }
        let viewController = INUIAddVoiceShortcutViewController(shortcut: shortcut)
        viewController.modalPresentationStyle = .formSheet
        viewController.delegate = self
        self.present(viewController, animated: true, completion: nil)
    }
}

extension SesameViewController: INUIAddVoiceShortcutViewControllerDelegate {
    func addVoiceShortcutViewController(_ controller: INUIAddVoiceShortcutViewController, didFinishWith voiceShortcut: INVoiceShortcut?, error: Error?) {
        controller.dismiss(animated: true, completion: {
            self.mainView.toggleSiriButton(delay: 2)
        })
    }

    func addVoiceShortcutViewControllerDidCancel(_ controller: INUIAddVoiceShortcutViewController) {
        controller.dismiss(animated: true, completion: nil)
    }
}
