//
//  CoinsViewIO.swift
//  CryptoApp
//
//  Created by Nikita Gras on 16.04.2021.
//

import Foundation

protocol CoinsViewInput: AnyObject, ViewInput {
    var coins: [Coin] {get}
    func setupInitialState()
    func startLoading()
    func stopLoading()
    func didLoadData(_ coins: [Coin])
    func showSearchResult(_ coins: [Coin])
}

protocol CoinsViewOutput {
    func viewIsReady()
    func getCoins()
    func updateSearchResult(with searchText: String)
}
