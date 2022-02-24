//
//  NewValue.swift
//  CryptoApp
//
//  Created by Nikita Gras on 17.05.2021.
//

import Foundation

struct TradingInfo {
    let price: Double
    let priceChange: Double
    let capitalization: Double
    let supply: Double
    let volume: Double
    
    init(_ raw: Any?) throws {
        guard let raw = raw as? [String:Any],
              let usd = raw["USD"] as? [String:Any],
              let price = usd["PRICE"] as? Double,
              let priceChange = usd["CHANGEPCT24HOUR"] as? Double,
              let cap = usd["MKTCAP"] as? Double,
              let supply = usd["SUPPLY"] as? Double,
              let vol = usd["VOLUME24HOUR"] as? Double else {
            throw SystemError.default
        }
        self.price = price
        self.priceChange = priceChange
        self.capitalization = cap
        self.supply = supply
        self.volume = vol
    }
}
