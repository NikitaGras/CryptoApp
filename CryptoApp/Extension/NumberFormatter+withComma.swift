//
//  NumberFormatter+myFormatter.swift
//  CryptoApp
//
//  Created by Nikita Gras on 19.05.2021.
//

import Foundation

extension NumberFormatter {
    static var withComma: NumberFormatter {
        let nf = NumberFormatter()
        nf.numberStyle = .decimal
        nf.locale = Locale(identifier: "en_US")
        return nf
    }
}
