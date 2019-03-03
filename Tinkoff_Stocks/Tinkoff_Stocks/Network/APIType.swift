//
//  APIType.swift
//  tinkoff_Stocks
//
//  Created by Mike Ovyan on 26/01/2019.
//  Copyright © 2019 Mike Ovyan. All rights reserved.
//

import Foundation

public protocol APIType {
    var path: String { get }
    var query: NetworkQuery { get }
}

public struct APIResource {
    public let url: String
    public let query: String?
}
