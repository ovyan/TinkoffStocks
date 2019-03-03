//
//  NetworkQuery.swift
//  tinkoff_Stocks
//
//  Created by Mike Ovyan on 26/01/2019.
//  Copyright © 2019 Mike Ovyan. All rights reserved.
//

import Foundation

public protocol QueryType {
    var items: [String: QueryConvertible] { get }

    var stringValue: String { get }
}

public struct NetworkQuery: QueryType {
    public let items: [String: QueryConvertible]

    public var stringValue: String {
        var components = [String]()

        for (k, v) in items {
            let encoded = String(using: v).addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
            let item = "\(k)=\(encoded)"
            components.append(item)
        }

        return components.joined(separator: "&")
    }
}
