//
//  FAQinputOutput.swift
//  CryptoApp
//
//  Created by Nikita Gras on 19.05.2021.
//

import Foundation

protocol FAQViewInput: AnyObject {
    var displayManager: FAQDisplayManager! { get }
}

protocol FAQViewOutput {
    func viewIsReady()
}
