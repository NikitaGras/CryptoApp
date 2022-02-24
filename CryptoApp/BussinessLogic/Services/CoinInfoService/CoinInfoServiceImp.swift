//
//  CoinInfoServiceImp.swift
//  CryptoApp
//
//  Created by Nikita Gras on 22.05.2021.
//

import Charts
import Alamofire

class CoinInfoServiceImp: CoinInfoService {
    static let shared = CoinInfoServiceImp()
    let baseUrlString: String = "https://min-api.cryptocompare.com"
    let apiKey = "da2253e84891246edace0b5d4dc1ef3021c1573499275b2d7fbef09b69449bc4"
    
    private init() {}
    
    func getHistoricalData(_ coin: Coin, for timePeriod: TimePeriod,
                           complitionHandler: @escaping ([ChartDataEntry]?, Error?) -> Void) {
        let paramData = ParamDecorator(timePeriod)
        let url = paramData.url(including: baseUrlString)
        let limit = paramData.limit
        let aggregate = paramData.aggregate
        
        let param: [String:Any] = ["fsym":coin.name, "tsym":"USD", "limit":limit,
                                   "aggregate" : aggregate, "api_key":apiKey]
        AF.request(url, parameters: param).validate().responseJSON { (response) in
            switch response.result {
            case .success(let data):
                guard let json = data as? [String:Any],
                      let dataObj = json["Data"] as? [String:Any],
                      let dataArr = dataObj["Data"] as? [[String:Any]] else {
                        return complitionHandler(nil, SystemError.default)
                }
                do {
                    var dataEntrys = [ChartDataEntry]()
                    try dataArr.forEach { item in
                        let data = try HistoricalData(from: item)
                        let dataEntryX = data.time
                        let dataEntryY = data.price
                        let dataEntry = ChartDataEntry(x: dataEntryX, y: dataEntryY)
                        dataEntrys.append(dataEntry)
                    }
                    complitionHandler(dataEntrys, nil)
                } catch {
                    complitionHandler(nil, error)
                }
            case .failure(let error):
                complitionHandler(nil, error)
            }
        }
    }
}

extension CoinInfoServiceImp {
    private class ParamDecorator {
        var timePeriod: TimePeriod
        
        init(_ timePeriod: TimePeriod) {
            self.timePeriod = timePeriod
        }
        
        var limit: Int {
            switch timePeriod {
            case .day:
                return 151
            case .week:
                return 168
            case .threeMonths:
                return 90
            case .year:
                return 365
            case .allTime:
                return 2000
            }
        }
        
        var aggregate: Int {
            switch timePeriod {
            case .day:
                return 10
            default:
                return 1
            }
        }
        
        func url(including baseUrlString: String) -> String {
            switch timePeriod {
            case .day:
                return "\(baseUrlString)/data/v2/histominute"
            case .week:
                return "\(baseUrlString)/data/v2/histohour"
            default:
                return "\(baseUrlString)/data/v2/histoday"
            }
        }
        
    }
}
