//
//  CoinInfoService.swift
//  CryptoApp
//
//  Created by Nikita Gras on 22.05.2021.
//

import Charts

protocol CoinInfoService {
    func getHistoricalData(_ coin: Coin, for timePeriod: TimePeriod,
                           complitionHandler: @escaping ([ChartDataEntry]?, Error?) -> Void)
}
