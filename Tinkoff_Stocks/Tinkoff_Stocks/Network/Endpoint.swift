//
//  NetworkType.swift
//  tinkoff_Stocks
//
//  Created by Mike Ovyan on 26/01/2019.
//  Copyright © 2019 Mike Ovyan. All rights reserved.
//

import Foundation

public typealias HTTPHeaderType = [String: String]

enum HTTPMethod: String {
    case GET, POST, PUT, DELETE
}

public struct Endpoint {
    let url: URL
    let headers: HTTPHeaderType?
}
