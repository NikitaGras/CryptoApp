//
//  Document.swift
//  CryptoApp
//
//  Created by Nikita Gras on 16.06.2021.
//

import Foundation

struct Document {
    let title: String
    let info: String
    let type: DocumentType
}

enum DocumentType {
    case document
    case subsription
    
    var description: String {
        switch self {
        case .document:
            return "Ссылки и документы"
        case .subsription:
            return "Подписка"
        }
    }
}
