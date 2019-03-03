//
//  NetworkModel.swift
//  tinkoff_Stocks
//
//  Created by Mike Ovyan on 26/01/2019.
//  Copyright © 2019 Mike Ovyan. All rights reserved.
//

import Foundation

public protocol NetworkModel {
    static func parseItem(_ data: Data) -> Self?

    static func parseArray(_ array: Data) -> [Self]
}

public extension NetworkModel {
    static func parseItem(_ data: Data) -> Self? {
        let me = type(of: self)
        print("\(me) didn't implement object parsing!")

        return nil
    }

    static func parseArray(_ array: Data) -> [Self] {
        let me = type(of: self)
        print("\(me) didn't implement array parsing!")

        return [Self]()
    }
}
