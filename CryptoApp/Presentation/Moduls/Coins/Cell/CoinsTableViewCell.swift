//
//  CoinTableViewCell.swift
//  CryptoApp
//
//  Created by Nikita Gras on 16.04.2021.
//

import UIKit
import Kingfisher

class CoinsTableViewCell: UITableViewCell {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var coinImageView: UIImageView!
    @IBOutlet weak var fullNameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var priceChangeLabel: UILabel!
    let formatter = NumberFormatter.withComma
    
    func fill(with coin: Coin) {
        nameLabel.text = coin.fullName
        fullNameLabel.text = coin.name
        
        let priceValue = NSNumber(value: coin.price ?? 0)
        let price = formatter.string(from: priceValue) ?? ""
        priceLabel.text = "$ " + price
        
        priceChangeLabel.text = (coin.priceChange?.round(2).description ?? "0") + "%"
        coinImageView.kf.setImage(with: coin.imageUrl)
        
        let green = UIColor(named: "CoinsGreen")
        let red = UIColor(named: "CoinsRed")
        priceChangeLabel.textColor = coin.priceChange ?? 0 > 0 ? green : red
    }
}
