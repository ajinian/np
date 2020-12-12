//
//  Extensions.swift
//  NennosPizza
//
//  Created by Arthur Jinian on 12/6/20.
//

import UIKit

extension Double {
    
    var stringCurrency: String {
        let currencyFormatter = NumberFormatter()
        currencyFormatter.usesGroupingSeparator = true
        currencyFormatter.numberStyle = .currency
        currencyFormatter.locale = Locale.current
        return currencyFormatter.string(from: NSNumber(value: self))!
    }
}
