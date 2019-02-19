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

enum WowAnimationType {
    case up, down, left, right
    case fadeIn, fadeInUp, fadeInDown, fadeInLeft, fadeInRight
    case scaleIn, scaleInUp, scaleInDown, scaleInLeft, scaleInRight
    case fadeInScale
}

extension UIView {
    func wow(type: WowAnimationType = .fadeIn, delay: TimeInterval = 0, duration: TimeInterval = 0.3, mode: UIView.AnimationOptions = .curveEaseOut) {
        var alpha: Float = 1
        var scale: CGFloat = 1
        var tx: CGFloat = 0
        var ty: CGFloat = 0

        switch type {
        case .fadeIn, .fadeInUp, .fadeInDown, .fadeInLeft, .fadeInRight: alpha = 0
        case .scaleIn, .scaleInUp, .scaleInDown, .scaleInLeft, .scaleInRight: scale = 0
        case .fadeInScale: alpha = 0; scale = 0
        default: break
        }

        switch type {
        case .up, .fadeInUp, .scaleInUp: ty = self.bounds.height
        case .down, .fadeInDown, .scaleInDown: ty = -self.bounds.height
        case .left, .fadeInLeft, .scaleInLeft: tx = self.bounds.width
        case .right, .fadeInRight, .scaleInRight: tx = -self.bounds.width
        default: break
        }

        self.layer.opacity = alpha
        self.transform = CGAffineTransform(a: scale, b: 0, c: 0, d: scale, tx: tx, ty: ty)
        self.setNeedsLayout()

        UIView.animate(withDuration: duration, delay: delay, options: mode, animations: {
            self.layer.opacity = 1
            self.transform = CGAffineTransform(a: 1, b: 0, c: 0, d: 1, tx: 0, ty: 0)
        })
    }
}
