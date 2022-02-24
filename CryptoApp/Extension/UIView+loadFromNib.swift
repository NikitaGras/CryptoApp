//
//  UIView+loadFromNib.swift
//  CryptoApp
//
//  Created by Nikita Gras on 09.06.2021.
//

import UIKit

extension UIView {
    func setupNib() {
        let view = loadFromNib()
        view.frame = bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(view)
    }
    
    func loadFromNib() -> UIView {
        let nibName = String(describing: CoinNavigationHeaderView.self)
        let nib = UINib(nibName: nibName, bundle: nil)
        let view = nib.instantiate(withOwner: self).first as! UIView
        return view
    }
    
}
