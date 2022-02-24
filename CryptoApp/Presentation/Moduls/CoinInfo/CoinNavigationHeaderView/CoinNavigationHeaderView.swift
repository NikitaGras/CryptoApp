//
//  CoinNavigationHeaderView.swift
//  CryptoApp
//
//  Created by Nikita Gras on 09.06.2021.
//

import UIKit
import Kingfisher

class CoinNavigationHeaderView: UIView {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
        setupNib()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        backgroundColor = .clear
        setupNib()
    }
    
    func fill(with coin: Coin) {
        nameLabel.text = coin.name
        let url = coin.imageUrl
        imageView.kf.setImage(with: url)
    }
}
