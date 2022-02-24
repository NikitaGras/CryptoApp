//
//  FavoriteServiceImp.swift
//  CryptoApp
//
//  Created by Nikita Gras on 06.05.2021.
//

import Alamofire

class FavoriteServiceImp: FavoriteService {
    static let shared = FavoriteServiceImp()
    private var coins: [Coin] = []
    
    let baseUrlString = "https://min-api.cryptocompare.com"
    var url: URL!
    
    let apiKey = "da2253e84891246edace0b5d4dc1ef3021c1573499275b2d7fbef09b69449bc4"
    
    private init() {
        let coins = (try? fetchCoins()) ?? [Coin]()
        self.coins = coins
        url = URL(string: baseUrlString + "/data/pricemultifull")
    }
    
    func updateCoins(complitionHandler: @escaping ([Coin]?, Error?) -> Void) {
        guard !coins.isEmpty else {
            return complitionHandler([], nil)
        }
        let coinsNameArr = coins.map { (coin) -> String in
            return coin.name
        }
        let coinsNameString = coinsNameArr.joined(separator: ",")
        let param: [String:Any] = ["fsyms": coinsNameString, "tsyms":"USD", "api_key":apiKey]
        
        AF.request(url, parameters: param).validate().responseJSON { (response) in
            switch response.result {
            case .success(let data):
                guard let json = data as? [String:Any],
                      let raw = json["RAW"] as? [String:Any] else {
                    return complitionHandler(nil, SystemError.default)
                }
                do {
                    var updatedCoins = self.coins
                    
                    try updatedCoins.enumerated().forEach { (index, coin) in
                        let newValue = try TradingInfo(raw[coin.name])
                        updatedCoins[index].update(with: newValue)
                    }
                    complitionHandler(updatedCoins,nil)
                } catch {
                    complitionHandler(nil, error)
                }
            case .failure(let error):
                complitionHandler(nil, error)
            }
        }
    }
    
    func isFavorite(_ coin: Coin) -> Bool {
        return coins.contains { (currentCoin) -> Bool in
            coin.name == currentCoin.name
        }
    }
    
    func add(_ coin: Coin) throws {
        if !isFavorite(coin) {
            coins.append(coin)
            try save(coins)
        }
    }
    
    func remove(_ coin: Coin) throws {
        coins.removeAll { (currentCoin) -> Bool in
            currentCoin.name == coin.name
        }
        try save(coins)
    }
    
    func fetchCoins() throws -> [Coin] {
        let key = UserDefaults.Key.favouriteCoins
        guard let data = UserDefaults.standard.data(forKey: key) else {
            return []
        }
        do {
            let coins = try JSONDecoder().decode([Coin].self, from: data)
            return coins
        } catch {
            throw SystemError.default
        }
    }
    
    func save(_ coins: [Coin]) throws {
        let data = try JSONEncoder().encode(coins)
        let key = UserDefaults.Key.favouriteCoins
        UserDefaults.standard.set(data, forKey: key)
    }
}
