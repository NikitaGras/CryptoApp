//
//  FAQViewPresenter.swift
//  CryptoApp
//
//  Created by Nikita Gras on 19.05.2021.
//

import Foundation

class FAQPresenter: FAQViewOutput {
    weak var view: FAQViewInput!
    let service = FAQService.shared
    var questions: [FAQ] {
        return service.dataBase
    }
    
    init(_ view: FAQViewInput) {
        self.view = view
    }
    
    func viewIsReady() {
        self.view.displayManager.set(questions)
    }
}
