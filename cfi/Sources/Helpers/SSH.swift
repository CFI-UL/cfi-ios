//
//  File.swift
//  cfi
//
//  Created by Alexandre Frigon on 2019-02-10.
//  Copyright © 2019 Frigstudio. All rights reserved.
//

import Foundation
import SwiftSH

class SSH {
    let username = "lab4A"
    let password = "fg3ts_d0e5n7_m4k3_y0u_1nv1nc1bl3"
    //let ip = "192.168.1.1"
    let ip = "rpisec.thehacker.space"

    func send(command: String) {
        let commandObject = Command(host: ip, port: 22)
        commandObject?.connect().authenticate(.byPassword(username: username, password: password)).execute(command) { (command, result: String?, error) in
                if let error = error {
                    print(error)
                    return
                }

                if let result = result {
                    print(result)
                }
        }
    }
}
