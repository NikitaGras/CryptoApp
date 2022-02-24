//
//  RoundButton.swift
//  CryptoApp
//
//  Created by Nikita Gras on 26.05.2021.
//

import UIKit

class RoundButton: UIButton {
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.cornerRadius = self.frame.size.height / 2
    }
}
