//
//  RootView.swift
//  cfi
//
//  Created by Alexandre Frigon on 2019-02-10.
//  Copyright © 2019 Frigstudio. All rights reserved.
//

import UIKit
import PinLayout

protocol RootViewDelegate: class {
    func didOpenDoor()
}

class RootView: UIView {
    weak var delegate: RootViewDelegate?

    private let doorButton = UIButton()
    private let logo = UIImageView()

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
    }

    @objc func openDoor(sender: Any) {
        self.delegate?.didOpenDoor()
    }
}
