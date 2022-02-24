//
//  Coin.swift
//  CryptoApp
//
//  Created by Nikita Gras on 16.04.2021.
//

import UIKit

struct Coin: Codable {
    let imageUrl: URL
    let name: String
    let fullName: String
    let hashAlgorithm: String
    let proofType: String
    
    var fromSymbol: String?
    var price: Double?
    var priceChange: Double?
    var capitalization: Double?
    var supply: Double?
    var volume: Double?

    init(_ dict: [String:Any]) throws {
        guard let coinInfo = dict["CoinInfo"] as? [String:Any],
              let name = coinInfo["Name"] as? String,
              let imageUrl = coinInfo["ImageUrl"] as? String,
              let url = URL(string: "https://www.cryptocompare.com\(imageUrl)"),
              let fullName = coinInfo["FullName"] as? String,
              let algorithm = coinInfo["Algorithm"] as? String,
              let proofType = coinInfo["ProofType"] as? String else {
            throw SystemError.default
        }
        let dispay = dict["DISPLAY"] as? [String:Any]
        let displayUsd = dispay?["USD"] as? [String:Any]
        let fromSymbol = displayUsd?["FROMSYMBOL"] as? String
        let raw = dict["RAW"] as? [String:Any]
        let usd = raw?["USD"] as? [String:Any]
        let price = usd?["PRICE"] as? Double
        let priceChange = usd?["CHANGEPCT24HOUR"] as? Double
        let cap = usd?["MKTCAP"] as? Double
        let supply = usd?["SUPPLY"] as? Double
        let vol = usd?["VOLUME24HOUR"] as? Double
        
        self.imageUrl = url
        self.name = name
        self.fullName = fullName
        self.hashAlgorithm = algorithm
        self.proofType = proofType
        self.fromSymbol = fromSymbol
        self.price = price
        self.priceChange = priceChange
        self.capitalization = cap
        self.supply = supply
        self.volume = vol
    }
    
    mutating func update(with data: TradingInfo) {
        price = data.price
        priceChange = data.priceChange
        capitalization = data.capitalization
        supply = data.supply
        volume = data.volume
    }
    
    func getInfo() -> [(name: String, value: NSAttributedString)] {
        let proofTypeTitle = CryptoCurrency.proofType.rawValue
        let proofTypeValue = NSAttributedString(string: self.proofType)
        let hashAlgorithmTitle = CryptoCurrency.hashAlgorithm.rawValue
        let hashAlgorithmValue = NSAttributedString(string: self.hashAlgorithm)
        var info: [(String, NSAttributedString)] = [
            (proofTypeTitle, proofTypeValue),
            (hashAlgorithmTitle, hashAlgorithmValue)
        ]
        if let capitalization = self.capitalization {
            let capitalizationTitle = CryptoCurrency.capitalization.rawValue
            let capitaliztionValue = NSAttributedString(string: "$ " + capitalization.commaSeparated())
            info.append((capitalizationTitle, capitaliztionValue))
        }
        if let supply = self.supply, let fromSymbol = self.fromSymbol {
            let supplyTitle = CryptoCurrency.supply.rawValue
            let supplyValue = NSAttributedString(string: fromSymbol + " " + supply.commaSeparated())
            info.append((supplyTitle, supplyValue))
        }
        if let priceChange = self.priceChange {
            let priceChangeTitle = CryptoCurrency.priceChange.rawValue
            
            let green = UIColor(named: "CoinsGreen")
            let red = UIColor(named: "CoinsRed")
            let textColor = priceChange.isLess(than: 0) ? red : green
            
            let priceChangeValue = NSAttributedString(string: priceChange.round(2).description + " %", attributes: [NSAttributedString.Key.foregroundColor : textColor ?? .black])
            info.append((priceChangeTitle, priceChangeValue))
        }
        if let volume = self.volume {
            let volumeTitle = CryptoCurrency.volume.rawValue
            let volumeValue = NSAttributedString(string: "$ " + volume.commaSeparated())
            info.append((volumeTitle, volumeValue))
        }
        return info
    }
}

enum CryptoCurrency: String {
    case proofType = "Алгоритм подтверждения"
    case hashAlgorithm = "Алгоритм хэширования"
    case capitalization = "Капитализация"
    case supply = "Предложение"
    case priceChange = "Изменение цены"
    case volume = "Обьём"
}
