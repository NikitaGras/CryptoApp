//
//  Presenter.swift
//  CryptoApp
//
//  Created by Nikita Gras on 16.04.2021.
//

import Foundation

class CoinsPresenter: CoinsViewOutput {
    let coinsService = CoinsServiceImp.shared
    weak var view: CoinsViewInput!
    
    init(_ view: CoinsViewInput) {
        self.view = view
    }
    
    //MARK: - CoinsViewOutput
    func viewIsReady() {
        self.view.setupInitialState()
        self.getCoins()
    }
    
    func getCoins() {
        self.view.startLoading()
        let limit = 100
        coinsService.getCoins(limit) { [weak self] (coins, error) in
            self?.view.stopLoading()
            if let coins = coins {
                self?.view.didLoadData(coins)
            }
            if let error = error {
                self?.view.show(error)
            }
        }
    }

    func updateSearchResult(with searchText: String) {
        var coins = view.coins

        if !searchText.isEmpty {
            coins = view.coins.filter { (coin) -> Bool in
                return coin.name.lowercased().contains(searchText) || coin.fullName.lowercased().contains(searchText)
            }
        }
        
        view.showSearchResult(coins)
    }
}
