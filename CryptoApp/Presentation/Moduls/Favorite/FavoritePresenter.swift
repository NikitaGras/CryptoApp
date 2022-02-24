//
//  FavoriteViewPresenter.swift
//  CryptoApp
//
//  Created by Nikita Gras on 07.05.2021.
//

import Foundation

class FavoritePresenter: FavoriteViewOutput {
    let service = FavoriteServiceImp.shared
    weak var view: FavoriteViewInput!
    var coins = [Coin]()
    
    init(_ view: FavoriteViewInput) {
        self.view = view
    }
    
    func viewIsReady() {
        view.setupInitialState()
    }
    
    func getCoins() {
        view.startLoading()
        service.updateCoins { [weak self] (coins, error) in
            self?.view.stopLoading()
            if let coins = coins {
                self?.coins = coins
                if coins.isEmpty {
                    self?.view.showEmptyLabel()
                } else {
                    self?.view.didLoadData(coins)
                }
            }
            if let error = error {
                self?.view.show(error)
            }
        }
    }
    
    func deleteFavourite(_ coin: Coin) {
        do {
            try service.remove(coin)
            coins.removeAll { currentCoin in
                currentCoin.name == coin.name
            }
            
            if coins.isEmpty {
                view.showEmptyLabel()
            }
        } catch {
            view.show(error)
        }
    }
    
}
