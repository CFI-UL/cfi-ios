//
//  IntentDonation.swift
//  cfi
//
//  Created by Alexandre Frigon on 2019-02-16.
//  Copyright © 2019 Frigstudio. All rights reserved.
//

import Intents

enum IntentDonationType {
    case openDoor
}

class IntentDonation {
    static func donate(_ type: IntentDonationType) {
        switch type {
        case .openDoor: IntentDonation.openDoor()
        }
    }

    private static func openDoor() {
        let intent = OpenDoorIntent()
        intent.suggestedInvocationPhrase = "Open the CFI door"
        INInteraction(intent: intent, response: nil).donate()
    }
}
