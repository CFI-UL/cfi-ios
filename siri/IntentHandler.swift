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

import Intents

class IntentHandler: INExtension, OpenDoorIntentHandling {
    override func handler(for intent: INIntent) -> Any {
        return self
    }

    func confirm(intent: OpenDoorIntent, completion: @escaping (OpenDoorIntentResponse) -> Void) {
        guard Authentification.shared.isAuthentificated() else {
            return completion(OpenDoorIntentResponse(code: OpenDoorIntentResponseCode.failureNoAuth, userActivity: nil))
        }
    }

    func handle(intent: OpenDoorIntent, completion: @escaping (OpenDoorIntentResponse) -> Void) {
        DoorService.sendRequest { error in
            if let error = error {
                if error.statusCode == .unauthorized {
                    return completion(OpenDoorIntentResponse(code: OpenDoorIntentResponseCode.failureNoAuth, userActivity: nil))
                }

                return completion(OpenDoorIntentResponse(code: OpenDoorIntentResponseCode.failure, userActivity: nil))
            }
        }

        return completion(OpenDoorIntentResponse(code: OpenDoorIntentResponseCode.success, userActivity: nil))
    }
}
