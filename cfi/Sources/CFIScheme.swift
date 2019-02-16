//
//  CFIScheme.swift
//  cfi
//
//  Created by Alexandre Frigon on 2019-02-15.
//  Copyright © 2019 Frigstudio. All rights reserved.
//

import Foundation

protocol CFISchemeDelegate: class {}

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
