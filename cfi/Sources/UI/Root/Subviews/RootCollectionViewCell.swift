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

class RootCollectionViewCell: UICollectionViewCell {
    let titleLabel = UILabel()
    let imageView = UIImageView()
    let tintFilter = CALayer()

//    override var isHighlighted: Bool {
//        get { return super.isHighlighted }
//        set {
//            super.isHighlighted = newValue
//            let newScale: CGFloat = newValue ? 0.95 : 1
//            UIView.animate(withDuration: 0.125, delay: 0, options: UIView.AnimationOptions.curveEaseInOut, animations: {
//                self.transform = CGAffineTransform(scaleX: newScale, y: newScale)
//            })
//        }
//    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor(hex: 0xf4f4f6)
        self.layer.cornerRadius = 10

        self.addSubview(self.titleLabel)
        self.addSubview(self.imageView)

        self.titleLabel.font = UIFont.apercu(ofSize: 20)
        self.titleLabel.textColor = .darkGray
        self.titleLabel.backgroundColor = .white
        self.titleLabel.textAlignment = .center

        self.imageView.contentMode = .scaleAspectFit

        self.layer.shadowOffset = CGSize(width: 3, height: 3)
        self.layer.shadowRadius = 5
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.2
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        self.titleLabel.pin.bottom().left().right().height(35%)
        self.imageView.pin.center().marginTop(-17%).size(50%)

        let maskPath = UIBezierPath(roundedRect: self.titleLabel.bounds, byRoundingCorners: [.bottomLeft, .bottomRight], cornerRadii: CGSize(width: 10.0, height: 10.0))
        let shape = CAShapeLayer()
        shape.path = maskPath.cgPath
        self.titleLabel.layer.mask = shape
    }

    func configure(title: String, icon: UIImage) {
        self.titleLabel.text = title
        self.imageView.image = icon
    }
}

/// Scale animation on highlight
extension RootCollectionViewCell {
    var scaleValue: CGFloat { return 0.95 }
    var animationDuration: TimeInterval { return 0.1 }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        UIView.animate(withDuration: self.animationDuration, delay: 0, options: UIView.AnimationOptions.curveEaseInOut, animations: {
            self.transform = CGAffineTransform(scaleX: self.scaleValue, y: self.scaleValue)
        })
        self.setNeedsLayout()
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        UIView.animate(withDuration: self.animationDuration, delay: 0, options: UIView.AnimationOptions.curveEaseInOut, animations: {
            self.transform = CGAffineTransform(scaleX: 1, y: 1)
        })
        self.setNeedsLayout()
    }

    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesMoved(touches, with: event)
        if let point = touches.first?.location(in: self) {
            if !self.bounds.contains(point) {
                UIView.animate(withDuration: self.animationDuration, delay: 0, options: UIView.AnimationOptions.curveEaseInOut, animations: {
                    self.transform = CGAffineTransform(scaleX: 1, y: 1)
                })
                self.setNeedsLayout()
            }
        }
    }

    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesCancelled(touches, with: event)
        UIView.animate(withDuration: self.animationDuration, delay: 0, options: UIView.AnimationOptions.curveEaseInOut, animations: {
            self.transform = CGAffineTransform(scaleX: 1, y: 1)
        })
        self.setNeedsLayout()
    }
}
