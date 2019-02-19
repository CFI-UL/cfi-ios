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

class FeatureView: UIView {
    private let imageViewContrainer = UIView()
    private let imageView = UIImageView()
    private let featureLabel = UILabel()

    init(icon: UIImage, description: String) {
        super.init(frame: .zero)
        self.imageView.image = icon
        self.featureLabel.text = description

        self.imageViewContrainer.addSubview(self.imageView)
        self.addSubview(self.imageViewContrainer)
        self.addSubview(self.featureLabel)

        self.imageViewContrainer.layer.borderColor = UIColor.white.cgColor
        self.imageViewContrainer.layer.borderWidth = 3.5

        self.imageView.tintColor = .translucentWhite

        self.featureLabel.font = UIFont.apercu(ofSize: 13)
        self.featureLabel.textColor = .translucentWhite
        self.featureLabel.numberOfLines = 0
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        self.imageViewContrainer.pin.top().left().size(85)
        self.imageView.pin.size(30).center()

        self.pin.left(50).right(50).wrapContent(.vertically)
        self.featureLabel.pin.right(of: self.imageViewContrainer, aligned: .center).right().height(100%).marginLeft(16)

        self.imageViewContrainer.layer.cornerRadius = self.imageViewContrainer.bounds.height / 2
    }
}
