//
//  Authentification.swift
//  cfi
//
//  Created by Alexandre Frigon on 2019-02-15.
//  Copyright © 2019 Frigstudio. All rights reserved.
//

import KeychainAccess

extension Request {
    func auth() -> Request {
        let accessToken = Authentification.shared.getToken()
        self.addHeader(RequestHeader.authorization(token: accessToken))
        return self
    }
}

protocol AuthentificationDelegate: CFISchemeDelegate {
    func didAuthenticate()
    func didCancelAuthentification()
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
        return !self.getToken().isEmpty
    }
}
