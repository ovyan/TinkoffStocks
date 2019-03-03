//
//  StockViewModel.swift
//  tinkoff_Stocks
//
//  Created by Mike Ovyan on 26/01/2019.
//  Copyright © 2019 Mike Ovyan. All rights reserved.
//

import UIKit

enum StockChangeType {
    case bull
    case bear
    case none
}

struct StockViewModel {

    let title: String

    let priceText: String
    
    let changeText: String

    let companyLogoURL: URL?

    private let changeType: StockChangeType
}

extension StockViewModel {
    init(with model: StockModel) {
        title = "\(model.ticker) (\(model.companyName))"
        priceText = "Price: $\(model.currentPrice.round(with: 2)) / $\(model.previousPrice.round(with: 2))"

        let change = model.change.round(with: 2)
        let changePercent = (model.changePercent * 100).round(with: 2)
        changeText = "\(change) (\(changePercent)%)"

        if model.change == 0 || model.changePercent == 0 {
            changeType = .none
        } else {
            changeType = model.change > 0 ? .bull : .bear
        }

        companyLogoURL = URL(string: "https://storage.googleapis.com/iex/api/logos/\(model.ticker).png")
    }
}

extension StockViewModel {
    var changeColor: UIColor {
        switch changeType {
        case .bull:
            return UIColor.rgbP3(101, 201, 122)
        case .bear:
            return UIColor.rgbP3(214, 87, 69)
        case .none:
            return .clear
        }
    }

    var changeViewHidden: Bool {
        return changeType == .none
    }

    var changeViewTransform: CGAffineTransform {
        switch changeType {
        case .bull, .none:
            return CGAffineTransform.identity
        case .bear:
            return CGAffineTransform(scaleX: 1, y: -1)
        }
    }
}
