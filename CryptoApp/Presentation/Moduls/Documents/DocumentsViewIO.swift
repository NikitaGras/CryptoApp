//
//  DocumentsViewIO.swift
//  CryptoApp
//
//  Created by Nikita Gras on 16.06.2021.
//

import Foundation

protocol DocumentsViewInput: AnyObject {
    func setupInitialState()
}

protocol DocumentsViewOutput {
    var documents: [[Document]] { get }
    
    func viewIsReady()
    func openLink()
}
