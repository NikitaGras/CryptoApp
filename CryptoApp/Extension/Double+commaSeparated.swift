//
//  Double+formatedValue.swift
//  CryptoApp
//
//  Created by Nikita Gras on 26.05.2021.
//

import Foundation

extension Double {
    func commaSeparated() -> String {
        let numberFormatter = NumberFormatter.withComma
        let value = NSNumber(value: self)
        let result = numberFormatter.string(from: value) ?? value.description
        return result
    }
}
