//
//  Double+round.swift
//  CryptoApp
//
//  Created by Nikita Gras on 19.04.2021.
//

import Foundation

extension Double {
    func round(_ digitCount: Int) -> Double {
        let multiplier: Double = pow(10, Double(digitCount))
        return (self * multiplier).rounded() / multiplier
    }
}
