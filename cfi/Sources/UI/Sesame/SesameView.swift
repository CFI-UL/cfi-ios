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
import IntentsUI
import PinLayout

protocol SesameViewDelegate: class {
    func didRequestClose()
    func didOpenDoor()
    func didAddToSiri()
}

fileprivate enum DoorState {
    case closed, loading, requested, opening
}

class SesameView: UIView {
    weak var delegate: SesameViewDelegate?

    private let titleLabel = TitleLabel(text: "Sesame")
    private let featureView = FeatureView(icon: #imageLiteral(resourceName: "icon-key"), description: "A request will be sent on Slack to open the door")

    private let closeButton = UIButton()
    private let doorButton = UIButton()
    private let siriButton = INUIAddVoiceShortcutButton(style: .whiteOutline)

    private let closeGesture = UISwipeGestureRecognizer()

    private var doorState: DoorState = .closed
    private var siriButtonOpened: Bool = false

    init() {
        super.init(frame: .zero)
        self.backgroundColor = .darkBlue

        self.addSubview(self.titleLabel)
        self.addSubview(self.featureView)
        self.addSubview(self.closeButton)
        self.addSubview(self.doorButton)
        self.addSubview(self.siriButton)
        self.addGestureRecognizer(self.closeGesture)

        self.closeButton.setImage(#imageLiteral(resourceName: "icon-close"), for: .normal)
        self.closeButton.tintColor = .white
        self.closeButton.addTarget(self, action: #selector(self.dismiss), for: .touchUpInside)

        self.doorButton.setTitle("Send open request", for: .normal)
        self.doorButton.backgroundColor = .white
        self.doorButton.setTitleColor(.black, for: .normal)
        self.doorButton.setTitleColor(UIColor.black.alterOpacity(by: -0.30), for: .highlighted)
        self.doorButton.layer.borderWidth = 1
        self.doorButton.layer.borderColor = UIColor.lightGray.cgColor
        self.doorButton.layer.cornerRadius = 14
        
        self.doorButton.titleLabel?.font = UIFont.apercuBold(ofSize: 13)
        self.doorButton.addTarget(self, action: #selector(self.openDoor), for: .touchUpInside)

        self.siriButton.shortcut = INShortcut(intent: OpenDoorIntent())!
        self.siriButton.translatesAutoresizingMaskIntoConstraints = false
        self.siriButton.addTarget(self, action: #selector(self.addToSiri), for: .touchUpInside)
        self.layoutSubviews()
        self.toggleSiriButton()

        self.closeGesture.direction = .down
        self.closeGesture.addTarget(self, action: #selector(self.dismiss))
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        self.titleLabel.pin.top(160).left(50).right(50).sizeToFit()
        self.featureView.pin.below(of: self.titleLabel, aligned: .start).marginTop(50)

        self.closeButton.pin.right(pin.safeArea.right).top(pin.safeArea.top).size(64)
        self.doorButton.pin.below(of: self.featureView).height(45).width(225).maxWidth(90%).hCenter().marginTop(100)

        self.layoutAnimatedView()
    }

    private func layoutAnimatedView() {
        if self.siriButtonOpened {
            self.siriButton.pin.bottom(50).hCenter()
        } else {
            self.siriButton.pin.bottom(-50).hCenter()
        }
    }

    func toggleSiriButton(delay: TimeInterval = 1) {
        self.siriButtonOpened = !self.siriButtonOpened
        UIView.animate(withDuration: 0.3, delay: delay, options: .curveEaseInOut, animations: {
            self.layoutAnimatedView()
        })
    }

    @objc func dismiss(_ sender: Any) {
        self.delegate?.didRequestClose()
    }

    @objc func openDoor(_ sender: Any) {
        self.delegate?.didOpenDoor()
    }

    @objc func addToSiri(_ sender: Any) {
        self.delegate?.didAddToSiri()
    }
}
