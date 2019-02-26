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

class Config {
    static let preserveSession: Bool = true
    static let mockAuth: Bool = false
    static let syncKeychain: Bool = true

    static let slackClientId: String = "86349330102.552696997859"
    static let apiHost: String = "http://web.poptheshell.com:8888"
    static let joinSlackHost: String = "http://slack.cfiul.ca"

    static let reverseDomain: String = "ca.cfiul.cfi"
    static var keychainService: String { return Config.reverseDomain }

    static let appIdentifierPrefix: String = "7LYG6KRX2T"
    static let keychainGroup: String = "shared"
    static var keychainAccessGroup: String {
        return "\(Config.appIdentifierPrefix).\(Config.keychainGroup)"
    }
}
