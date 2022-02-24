//
//  FavoriteViewIO.swift
//  CryptoApp
//
//  Created by Nikita Gras on 07.05.2021.
//

import Foundation

protocol FavoriteViewInput: AnyObject, ViewInput {
    func setupInitialState()
    func startLoading()
    func stopLoading()
    func didLoadData(_ coins: [Coin])
    func showEmptyLabel() 
}

protocol FavoriteViewOutput {
    var coins: [Coin] { get }
    func viewIsReady()
    func getCoins()
    func deleteFavourite(_ coin: Coin)
}
