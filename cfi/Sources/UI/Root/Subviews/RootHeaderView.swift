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

class RootHeaderView: UICollectionReusableView {
    private let welcomeLabel = TitleLabel(text: "Welcome")
    private let nameLabel = TitleLabel(text: "")
    private let profileImageView = UIImageView()

    private let titleLabel = TitleLabel(text: "Home")

    override init(frame: CGRect) {
        super.init(frame: .zero)
        self.backgroundColor = .white

        self.addSubview(self.welcomeLabel)
        self.addSubview(self.nameLabel)
        self.addSubview(self.profileImageView)
        self.addSubview(self.titleLabel)

        self.titleLabel.font = UIFont.apercuBold(ofSize: 28)
        self.titleLabel.textColor = .primary

        self.nameLabel.adjustsFontSizeToFitWidth = true
        self.nameLabel.minimumScaleFactor = 0.32

        self.profileImageView.contentMode = .scaleAspectFill
        self.profileImageView.clipsToBounds = true

        self.layoutSubviews()
        self.welcomeLabel.wow(type: .fadeInDown, delay: 0.25)
        self.nameLabel.wow(type: .fadeInDown, delay: 0.2)
        self.titleLabel.wow(type: .fadeInRight, delay: 0.55)
        self.profileImageView.wow(type: .fadeIn, delay: 0.3)
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        let titleLabelMargin: CGFloat = 75
        let padding: CGFloat = 50

        self.welcomeLabel.pin.left(pin.safeArea.left + padding).top(pin.safeArea.top + padding).sizeToFit()

        self.profileImageView.pin.below(of: self.welcomeLabel).right(pin.safeArea.right + padding).size(90)
        self.profileImageView.layer.cornerRadius = self.profileImageView.bounds.height / 2

        self.nameLabel.pin.below(of: self.welcomeLabel).left(padding).right(to: self.profileImageView.edge.left).height(of: self.welcomeLabel).marginRight(20)

        self.titleLabel.pin.below(of: self.nameLabel, aligned: .start).marginTop(titleLabelMargin).sizeToFit()
        self.pin.height(pin.safeArea.top +
            padding +
            self.welcomeLabel.bounds.height +
            self.nameLabel.bounds.height +
            titleLabelMargin +
            self.titleLabel.bounds.height + 20)
    }

    override func draw(_ rect: CGRect) {
        super.draw(rect)

        let curveOriginHeight = self.bounds.height - self.titleLabel.bounds.height - 45

        let path = UIBezierPath()
        path.move(to: CGPoint(x: 0, y: 0))
        path.addLine(to: CGPoint(x: 0, y: curveOriginHeight))
        path.addCurve(to: CGPoint(x: self.bounds.width, y: self.bounds.height - 25),
                      controlPoint1: CGPoint(x: 0.65 * self.bounds.height, y: curveOriginHeight - 5),
                      controlPoint2: CGPoint(x: 0.4 * self.bounds.width, y: self.bounds.height))
        path.addLine(to: CGPoint(x: self.bounds.width, y: 0))
        path.close()

        UIColor.primary.setFill()
        path.fill()
    }

    func configure(name: String, profileImage: UIImage?) {
        var name = "\((name.split(separator: " ").first ?? "").capitalized)"
        name += name.isEmpty ? "" : "."

        self.nameLabel.text = name
        self.profileImageView.image = profileImage
        self.setNeedsLayout()
        self.layoutSubviews()
    }
}
