//
//  UICollectionView+FlowLayout.swift
//  tinkoff_Stocks
//
//  Created by Mike Ovyan on 26/01/2019.
//  Copyright © 2019 Mike Ovyan. All rights reserved.
//

import UIKit

public extension UICollectionView {
    public var flowLayout: UICollectionViewFlowLayout {
        let layout = collectionViewLayout as? UICollectionViewFlowLayout
        assert(layout != nil)

        return layout!
    }
}

public extension UICollectionView {
    public convenience init(scrollDirection: UICollectionView.ScrollDirection) {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = scrollDirection

        self.init(frame: .zero, collectionViewLayout: layout)
    }
}
