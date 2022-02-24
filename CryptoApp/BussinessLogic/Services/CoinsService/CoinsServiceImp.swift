//
//  CryptoServerImp.swift
//  CryptoApp
//
//  Created by Nikita Gras on 16.04.2021.
//

import Alamofire

class CoinsServiceImp: CoinsService {
    static let shared = CoinsServiceImp()
    
    let baseUrlString = "https://min-api.cryptocompare.com"
    let url: URL!
    let apiKey = "da2253e84891246edace0b5d4dc1ef3021c1573499275b2d7fbef09b69449bc4"
    var limit: Int = 100 {
        didSet {
            if limit < 0 {
                limit = 0
            }
            if limit > 100 {
                limit = 100
            }
        }
    }
    
    private init() {
        url = URL(string: "\(baseUrlString)/data/top/mktcapfull")
    }
    
    func getCoins(_ limit: Int, completionHandler: @escaping ([Coin]?, Error?) -> Void) {
        let param: [String:Any] = ["limit":limit, "tsym":"USD", "api_key":apiKey]
        AF.request(url, parameters: param).validate().responseJSON { (response) in
            switch response.result {
            case .success(let data):
                do {
                    guard let json = data as? [String:Any],
                          let dataArray = json["Data"] as? [[String:Any]] else {
                        throw SystemError.default
                    }
                    var coins = [Coin]()
                    try dataArray.forEach { (dict) in
                        coins.append(try Coin(dict))
                    }
                    guard !coins.isEmpty else {
                        throw SystemError.default
                    }
                    
                    completionHandler(coins, nil)
                } catch {
                    completionHandler(nil, error)
                }
            case .failure(let error):
                completionHandler(nil, error)
            }
        }
    }
}
