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
    func didRequestTransition(to viewController: UIViewController)
}

class RootView: UIView {
    weak var delegate: RootViewDelegate?

    private let refreshView = UIView()
    private let collectionView: UICollectionView
    private let buttons = [
        ("Events", #imageLiteral(resourceName: "events")),
        ("Contests", #imageLiteral(resourceName: "contests")),
        ("Projects", #imageLiteral(resourceName: "projects")),
        ("Photos", #imageLiteral(resourceName: "photos")),
        ("Sesame", #imageLiteral(resourceName: "sesame"))
    ]

    private var name: String = ""
    private var profileImage: UIImage?

    init() {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 50, bottom: 50, right: 50)
        layout.minimumInteritemSpacing = 25
        layout.minimumLineSpacing = 25

        self.collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        self.collectionView.backgroundColor = .white

        super.init(frame: .zero)
        self.backgroundColor = .primary

        self.addSubview(self.collectionView)
        self.collectionView.addSubview(self.refreshView)

        self.collectionView.register(RootCollectionViewCell.self, forCellWithReuseIdentifier: "root-cell")
        self.collectionView.register(RootHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "root-header")
        self.collectionView.delegate = self
        self.collectionView.dataSource = self

        self.refreshView.backgroundColor = .primary
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        self.collectionView.pin.horizontally().top(pin.safeArea.top).bottom()
        self.refreshView.pin.above(of: self.collectionView).horizontally().height(of: self.collectionView)
    }

    func setUserInfo(name: String, profileImage: UIImage) {
        self.name = name
        self.profileImage = profileImage
        self.collectionView.reloadData() // should only reload the header
    }
}

extension RootView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellSize = (self.bounds.width - (2*50) - 25) / 2
        return CGSize(width: cellSize, height: cellSize)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: self.bounds.width, height: 290)
    }
}

extension RootView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.buttons.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = self.collectionView.dequeueReusableCell(withReuseIdentifier: "root-cell", for: indexPath) as? RootCollectionViewCell ?? RootCollectionViewCell()
        cell.configure(title: self.buttons[indexPath.row].0, icon: self.buttons[indexPath.row].1)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard kind == UICollectionView.elementKindSectionHeader else {
            return UICollectionReusableView()
        }

        let header = self.collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "root-header", for: indexPath) as? RootHeaderView ?? RootHeaderView()
        //        header.setUserInfo(name: self.name, profileImage: self.profileImage ?? UIImage()) // replace with default image
        return header
    }
}

extension RootView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        var viewController: UIViewController
        // could remove this with a view controller factory and an enum entry stored in the button array
        switch indexPath.row {
        case 0: return
        case 1: return
        case 2: return
        case 3: return
        case 4: viewController = SesameViewController()
        default: return
        }

        self.delegate?.didRequestTransition(to: viewController)
    }
}
