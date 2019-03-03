//
//  Promise+Optional.swift
//  tinkoff_Stocks
//
//  Created by Mike Ovyan on 26/01/2019.
//  Copyright © 2019 Mike Ovyan. All rights reserved.
//

import Foundation

public extension Promise {
    public convenience init(optional: Value?) {
        self.init()

        if let value = optional { fulfill(value) }
    }

    public func fulfill(optional: Value?) {
        if let value = optional { fulfill(value) }
    }
}

public extension Promise {
    public static func fromOptional(_ value: Value?) -> Promise<Value> {
        return Promise(optional: value)
    }

    public static func fromOptional(_ values: [Value?]) -> Promise<[Value]> {
        let values = values.filter { $0 != nil } as! [Value]

        return Promise<[Value]>(value: values)
    }
}
