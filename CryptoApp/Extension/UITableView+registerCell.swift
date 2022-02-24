//
//  UITableView+registerCell.swift
//  CryptoApp
//
//  Created by Nikita Gras on 26.05.2021.
//

import UIKit

extension UITableView {
    func register(cell cellType: UITableViewCell.Type) {
        self.register(cellType.nib, forCellReuseIdentifier: cellType.identifier)
    }
}
