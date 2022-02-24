//
//  SystemError.swift
//  CryptoApp
//
//  Created by Nikita Gras on 16.04.2021.
//

import Foundation

enum SystemError: LocalizedError {
    case `default`
    
    var errorDescription: String? {
        switch self {
        case .default:
            return "Простите, что-то пошло не так"
        }
    }
}
