//
//  CoinInfoIO.swift
//  CryptoApp
//
//  Created by Nikita Gras on 21.04.2021.
//

import Charts

protocol CoinInfoInput: AnyObject, ViewInput {
    var coin: Coin! {get}
    func setupinitialState()
    func setupChartView(with data: LineChartData)
    func startLoading()
    func stopLoading()
    func show(message: String)
}

protocol CoinInfoOutput {
    func viewIsReady()
    func toggleFavourite(_ coin: Coin) throws
    func isFavorite(_ coin: Coin) -> Bool
    func getHistoricalData(for coin: Coin, for timePeriod: TimePeriod)
}
