//
//  DocumentsTableViewCell.swift
//  CryptoApp
//
//  Created by Nikita Gras on 16.06.2021.
//

import UIKit

class DocumentsTableViewCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    
    func fill(with document: Document) {
        titleLabel.text = document.title
    }
}
