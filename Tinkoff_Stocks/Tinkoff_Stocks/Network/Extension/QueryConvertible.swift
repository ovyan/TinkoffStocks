//
//  QueryConvertible.swift
//  tinkoff_Stocks
//
//  Created by Mike Ovyan on 26/01/2019.
//  Copyright © 2019 Mike Ovyan. All rights reserved.
//

import Foundation

public protocol QueryConvertible: LosslessStringConvertible {}

extension Bool: QueryConvertible {}

extension String: QueryConvertible {}

extension Int: QueryConvertible {}

extension Double: QueryConvertible {}

extension String {
    public init(using value: QueryConvertible) {
        self.init("\(value)")
    }
}
