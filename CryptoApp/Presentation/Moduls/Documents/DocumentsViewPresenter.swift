//
//  DocumentsViewPresenter.swift
//  CryptoApp
//
//  Created by Nikita Gras on 16.06.2021.
//

import Foundation

class DocumentsViewPresenter: DocumentsViewOutput {
    weak var view: DocumentsViewInput!
    var service = DocumentsService.shared
    var documents: [[Document]] {
        return service.dataBase
    }
    
    init(_ view: DocumentsViewInput) {
        self.view = view
    }
    
    func viewIsReady() {
        view.setupInitialState()
    }
    
    func openLink() {
        
    }
}
