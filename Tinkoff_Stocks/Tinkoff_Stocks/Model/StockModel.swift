//
//  StockModel.swift
//  tinkoff_Stocks
//
//  Created by Mike Ovyan on 26/01/2019.
//  Copyright © 2019 Mike Ovyan. All rights reserved.
//

import Foundation

struct StockModel {
    let ticker: String
    let companyName: String
    let currentPrice: Double
    let previousPrice: Double
    let change: Double
    let changePercent: Double
}

extension StockModel: Unmarshaling {
    init(object: MarshaledObject) throws {
        ticker = try object.value(for: "symbol")
        companyName = try object.value(for: "companyName")

        currentPrice = try object.value(for: "latestPrice")
        previousPrice = try object.value(for: "previousClose")

        change = try object.value(for: "change")
        changePercent = try object.value(for: "changePercent")
    }
}
