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
import PinLayout

protocol RootViewDelegate: class {
    func didOpenDoor()
}

fileprivate enum DoorState {
    case closed, loading, requested, opening
}

class RootView: UIView {
    weak var delegate: RootViewDelegate?

    private let doorButton = UIButton()
    private let logo = UIImageView()

    private var doorState: DoorState = .closed

    init() {
        super.init(frame: .zero)

        self.addSubview(self.doorButton)
        self.addSubview(self.logo)

        self.backgroundColor = .white

        self.logo.image = #imageLiteral(resourceName: "LogoCFI")

        self.doorButton.setTitle("OPEN THE DOOR", for: .normal)
        self.doorButton.backgroundColor = .primary
        self.doorButton.setTitleColor(.white, for: .normal)
        self.doorButton.addTarget(self, action: #selector(self.openDoor), for: .touchUpInside)
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        self.logo.pin.width(50%).maxWidth(300).aspectRatio().center().marginTop(-48)
        self.doorButton.pin.below(of: self.logo).height(45).width(90%).maxWidth(300).hCenter().marginTop(48)
        self.doorButton.layer.cornerRadius = self.doorButton.bounds.height/2

//        switch self.doorState {
//            case
//        }
    }

    @objc func openDoor(sender: Any) {
        self.delegate?.didOpenDoor()
    }
}
