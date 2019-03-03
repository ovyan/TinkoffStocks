//
//  StockCell.swift
//  tinkoff_Stocks
//
//  Created by Mike Ovyan on 26/01/2019.
//  Copyright © 2019 Mike Ovyan. All rights reserved.
//

import UIKit

final class StockCell: UICollectionViewCell {

    func update(with model: StockViewModel) {
        titleLabel.text = model.title
        priceLabel.text = model.priceText
        changeLabel.text = model.changeText

        cornerView.backgroundColor = model.changeColor
        companyImageView.kf.setImage(with: model.companyLogoURL)
        
        if companyImageView.image == nil { //no image
            companyImageView.image = UIImage(named: "placeholder")
        }
        updateLayout()
    }

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.text = "AAPL"

        return label
    }()

    private let priceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.text = "Price: $1000 / $1000"

        return label
    }()

    private let changeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.text = "Change: $5 (1%)"

        return label
    }()

    private let companyImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 8

        return imageView
    }()

    private let shadowView: UIView = { //SHADOW? ? ?
        let view = UIView()
        view.backgroundColor = CUI.Feed.Cell.backgroundColor
        view.layer.cornerRadius = 8

        view.layer.shadowRadius = 5
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.15
        view.layer.shadowOffset = CGSize(width: 0, height: 3)

        return view
    }()
    
    private let cornerView: UIView = {
        let screenSize = UIScreen.main.bounds
        let screenWidth = screenSize.width - 32
        let height = screenWidth / 4 < 80 ? 80 : screenWidth / 4
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 7, height: height + 0.5))
        view.backgroundColor = .red
        view.clipsToBounds = true
        view.layer.cornerRadius = 5
        view.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMinXMinYCorner]
        return view
    }()
    
    private var model: StockViewModel?

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        internalInit()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        internalInit()
    }

    private func internalInit() {
        contentView.addSubview(shadowView)
        
        backgroundColor = CUI.Feed.Cell.backgroundColor
        
        contentView.addSubviews(titleLabel, priceLabel,
                                changeLabel,
                                companyImageView)
        contentView.addSubview(cornerView)
    }

    override func prepareForReuse() {
        super.prepareForReuse()

        companyImageView.kf.cancelDownloadTask()
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        updateLayout()
    }

    private func updateLayout() {
        companyImageView.pin.vCenter().right(16).size(64)

        titleLabel.pin.top(8).left(16).before(of: companyImageView).marginRight(16).sizeToFit(.width)
        priceLabel.pin.below(of: titleLabel, aligned: .left).before(of: companyImageView).marginTop(8).marginRight(16).sizeToFit(.width)

        changeLabel.pin.below(of: priceLabel, aligned: .left).marginTop(8).sizeToFit()

        shadowView.pin.all()
    }
}
