//
//  CoinInfoTableViewCell.swift
//  CryptoApp
//
//  Created by Nikita Gras on 26.05.2021.
//

import UIKit

class CoinInfoTableViewCell: UITableViewCell {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var valueLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
    }
    
    func fill(with coinInfo: (name: String, value: NSAttributedString)) {
        self.nameLabel.text = coinInfo.name
        valueLabel.attributedText = coinInfo.value
    }
}
