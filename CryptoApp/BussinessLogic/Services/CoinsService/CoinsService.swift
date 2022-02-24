//
//  CryptoServer.swift
//  CryptoApp
//
//  Created by Nikita Gras on 16.04.2021.
//

import Foundation

protocol CoinsService {
    func getCoins(_ limit: Int, completionHandler: @escaping(_ coins: [Coin]?, _ error: Error?) -> Void)
}
