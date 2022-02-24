//
//  DocumentsService.swift
//  CryptoApp
//
//  Created by Nikita Gras on 16.06.2021.
//

import Foundation

class DocumentsService {
    static var shared = DocumentsService()
    var dataBase: [[Document]]
    
    private init() {
        var dataBase = [[Document]]()
        
        var documents = [Document]()
        documents.append(Document(title: "Поддержка", info: "", type: .document))
        documents.append(Document(title: "Политика конфиденциальности", info: "", type: .document))
        documents.append(Document(title: "Terms of service", info: "", type: .document))
        dataBase.append(documents)
        
        var subscription = [Document]()
        subscription.append(Document(title: "Подписаться", info: "", type: .subsription))
        subscription.append(Document(title: "Восстановить подписку", info: "", type: .subsription))
        dataBase.append(subscription)
        
        self.dataBase = dataBase
    }
}
