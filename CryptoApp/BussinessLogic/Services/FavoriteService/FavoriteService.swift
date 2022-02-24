//
//  FavoriteService.swift
//  CryptoApp
//
//  Created by Nikita Gras on 06.05.2021.
//

import Foundation

protocol FavoriteService {
    func add(_ coin: Coin) throws
    func remove(_ coin: Coin) throws
    func isFavorite(_ coin: Coin) -> Bool
    func updateCoins(complitionHandler: @escaping ([Coin]?, Error?) -> Void)
}
