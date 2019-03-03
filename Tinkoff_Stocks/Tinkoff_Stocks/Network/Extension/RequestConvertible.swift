//
//  RequestConvertible.swift
//  tinkoff_Stocks
//
//  Created by Mike Ovyan on 26/01/2019.
//  Copyright © 2019 Mike Ovyan. All rights reserved.
//

import Foundation

public enum RequestConvertible {
    case urlRequest(URLRequest)
    case url(URL)
    case string(String)
}
