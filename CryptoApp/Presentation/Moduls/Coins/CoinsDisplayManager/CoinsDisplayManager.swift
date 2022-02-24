//
//  CoinsDisplayManager.swift
//  CryptoApp
//
//  Created by Nikita Gras on 17.04.2021.
//

import UIKit

protocol CoinsDisplaymanagerDelegate: AnyObject {
    func displayManager(_ displayManager: CoinsDisplayManager, didSelectCoin coin: Coin)
    func displayManager(_ displayManager: CoinsDisplayManager, deleteCoin coin: Coin)
}
