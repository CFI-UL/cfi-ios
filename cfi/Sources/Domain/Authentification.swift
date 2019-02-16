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

import KeychainAccess

extension Request {
    func auth() -> Request {
        let accessToken = Authentification.shared.getToken()
        self.addHeader(RequestHeader.authorization(token: accessToken))
        return self
    }
}

class Authentification {
    static var shared: Authentification = Authentification()

    static var authorizationURL: URL {
        let host: String = "https://cfi-ul.slack.com/oauth/authorize"
        let scope: String = "identity.basic,identity.avatar,identity.email"
        let redirectURI: String = "\(Config.apiHost)/auth"

        return URL(string: "\(host)?scope=\(scope)&client_id=\(Config.slackClientId)&redirect_uri=\(redirectURI)")!
    }

    let keychain = Keychain(service: "ca.cfi-ul.cfi")

    func saveToken(_ token: String) {
        self.keychain["access_token"] = token
    }

    func getToken() -> String {
        return self.keychain["access_token"] ?? ""
    }

    func clearToken() {
        self.keychain["access_token"] = nil
    }

    func isAuthentificated() -> Bool {
        return true || !self.getToken().isEmpty
    }
}
