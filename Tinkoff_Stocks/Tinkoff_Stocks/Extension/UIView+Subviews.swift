//
//  UIView+Subview.swift
//  tinkoff_Stocks
//
//  Created by Mike Ovyan on 26/01/2019.
//  Copyright © 2019 Mike Ovyan. All rights reserved.
//

import UIKit

public extension UIView {
    public func addSubviews(_ views: UIView...) {
        addSubviews(views)
    }

    public func addSubviews(_ views: [UIView]) {
        views.forEach { addSubview($0) }
    }

    public func removeAllSubviews() {
        subviews.forEach { $0.removeFromSuperview() }
    }
}
