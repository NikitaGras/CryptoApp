//
//  ViewInput.swift
//  CryptoApp
//
//  Created by Nikita Gras on 18.04.2021.
//

import UIKit

protocol ViewInput {
    func show(_ error: Error)
}

extension ViewInput {
    func show(_ error: Error) {
        guard let vc = self as? UIViewController else { return }
        let alertVC = UIAlertController(title: nil, message: error.localizedDescription, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertVC.addAction(action)
        vc.present(alertVC, animated: true, completion: nil)
    }
}
