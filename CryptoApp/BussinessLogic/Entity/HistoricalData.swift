//
//  HistoricalData.swift
//  CryptoApp
//
//  Created by Nikita Gras on 22.05.2021.
//

import Foundation

struct HistoricalData {
    let time: Double
    let price: Double
    
    init(from data: [String:Any]) throws {
              guard let time = data["time"] as? Double,
                    let price = data["close"] as? Double else {
            throw SystemError.default
        }
        self.time = time
        self.price = price
    }
}
