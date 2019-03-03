//
//  Double+Round.swift
//  tinkoff_Stocks
//
//  Created by Mike Ovyan on 26/01/2019.
//  Copyright © 2019 Mike Ovyan. All rights reserved.
//

import Foundation

public extension Double {
    /// Formats the double with decimal places count.
    public func round(with places: Int) -> String {
        return String(format: "%.\(places)f", self)
    }
}

public extension Double {
    /// Rounds the double to decimal places value.
    public func rounded(to places: Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}
