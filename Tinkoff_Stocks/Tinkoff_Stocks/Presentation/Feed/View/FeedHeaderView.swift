//
//  FeedHeaderView.swift
//  tinkoff_Stocks
//
//  Created by Mike Ovyan on 26/01/2019.
//  Copyright © 2019 Mike Ovyan. All rights reserved.
//

import UIKit

final class FeedHeaderView: UIView {
    var onRefresh: VoidBlock?

    private let refreshIconImageView: UIImageView = {
        let imageView = UIImageView(image: CUI.Icons.refreshIcon)
        imageView.isUserInteractionEnabled = true
        imageView.contentMode = .scaleAspectFit

        return imageView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)

        backgroundColor = .yellow
        
        layer.shadowRadius = 5
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.15
        layer.shadowOffset = CGSize(width: 0, height: 3)
        addSubview(refreshIconImageView)
        handleRefresh()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    private func handleRefresh() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(notifyRefreshObserver))
        refreshIconImageView.addGestureRecognizer(tap)
    }

    private func rotate() {
        let rotation = refreshIconImageView.transform.rotated(by: .pi)

        UIView.animate(withDuration: 0.3) {
            self.refreshIconImageView.transform = rotation
            self.refreshIconImageView.layoutIfNeeded()
        }
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        pin.width(refreshIconImageView.frame.width * 1.8)
            .aspectRatio(1)

        refreshIconImageView.pin
            .center()

        layer.cornerRadius = frame.height / 2
    }

    @objc
    private func notifyRefreshObserver() {
        rotate()
        onRefresh?()
    }
}
