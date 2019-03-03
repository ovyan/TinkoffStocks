//
//  Constants.swift
//  tinkoff_Stocks
//
//  Created by Mike Ovyan on 26/01/2019.
//  Copyright © 2019 Mike Ovyan. All rights reserved.
//

import UIKit

enum CUI {
    enum Feed {
        static let backgroundColor = UIColor.hex(0x212121)

        enum Cell {
            static let backgroundColor = UIColor.hex(0xFEFEFE)
        }
    }

    enum Icons {
        static let refreshIcon: UIImage? = UIImage(named: "reload")
    }

    static let themeColor = UIColor.hex(0x212121)

    static let themeTextColor = UIColor.hex(0xFEFEFE)
}

enum CNET {
    static let stockListURL = "https://api.iextrading.com/1.0/stock/market/list/infocus"
}

enum CSTR {
    static let noConnectionMessage = "Looks like there's no internet connection available!"

    static let apiErrorMessage = "Something went wrong!\nCheck your internet connection"
}
