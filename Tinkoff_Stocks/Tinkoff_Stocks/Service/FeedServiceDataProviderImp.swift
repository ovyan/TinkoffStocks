//
//  FeedServiceDataProviderImp.swift
//  tinkoff_Stocks
//
//  Created by Mike Ovyan on 26/01/2019.
//  Copyright © 2019 Mike Ovyan. All rights reserved.
//

import Foundation

final class FeedServiceDataProviderImp: FeedServiceDataProvider {

    func loadData() -> Promise<[StockModel]> {
        guard let endpoint = adapter.adapt(CNET.stockListURL) else { fatalError() }

        return response.getArray(endpoint)
    }

    private let adapter = ResourceAdapter()

    private let response = ResponseProvider()
}
