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

import Foundation

protocol CFISchemeDelegate: class {}

protocol AuthentificationDelegate: CFISchemeDelegate {
    func didAuthenticate()
    func didCancelAuthentification()
}

class CFIScheme {
    weak var delegate: CFISchemeDelegate?
    let command: String

    init(_ command: String, delegate: CFISchemeDelegate? = nil) {
        self.command = command
        self.delegate = delegate
    }

    func process(_ params: [URLQueryItem]?) {
        switch self.command {
        case "Auth":
            guard let params = params else { return }
            self.auth(params)
        default:
            print("Unknown CFI scheme command \(self.command)")
            return
        }
    }

    private func auth(_ params: [URLQueryItem]) {
        guard let token = params.first(where: { $0.name == "access_token" })?.value else {
            print(params)

            if let delegate = self.delegate as? AuthentificationDelegate {
                delegate.didCancelAuthentification()
            }

            return
        }

        Authentification.shared.saveToken(token)

        if let delegate = self.delegate as? AuthentificationDelegate {
            delegate.didAuthenticate()
        }
    }
}
