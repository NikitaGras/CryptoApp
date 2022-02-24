//
//  CoinInfoPresenter.swift
//  CryptoApp
//
//  Created by Nikita Gras on 21.04.2021.
//

import Charts

class CoinInfoPresenter: CoinInfoOutput {
    let favouriteService = FavoriteServiceImp.shared
    let coinInfoService = CoinInfoServiceImp.shared
    
    weak var view: CoinInfoInput!
    
    init(_ view: CoinInfoInput) {
        self.view = view
    }
    
    func viewIsReady() {
        view.setupinitialState()
        getHistoricalData(for: view.coin, for: .day)
    }
    
    func getHistoricalData(for coin: Coin, for timePeriod: TimePeriod) {
        view.startLoading()
        coinInfoService.getHistoricalData(coin, for: timePeriod) { chartDataEntry, error in
            if let chartDataEntry = chartDataEntry {
                let dataSet = LineChartDataSet(chartDataEntry)
                self.setup(dataSet)
                let data = LineChartData(dataSet: dataSet)
                self.setup(data)
                self.view.setupChartView(with: data)
            }
            if let error = error {
                self.view.show(error)
            }
            self.view.stopLoading()
        }
    }
    
    private func setup(_ dataSet: LineChartDataSet) {
        dataSet.drawCirclesEnabled = false
        dataSet.setColor(.blue)
        dataSet.drawHorizontalHighlightIndicatorEnabled = false
        dataSet.highlightColor = .gray
        
        let colorArray = [CGColor(srgbRed: 0.1, green: 0.1, blue: 0.9, alpha: 0.9),
                          CGColor(srgbRed: 0, green: 0, blue: 0, alpha: 0)]
        if let gradient = CGGradient(colorsSpace: nil, colors: colorArray as CFArray, locations: nil) {
            dataSet.fill = Fill(linearGradient: gradient, angle: 270)
        }
        dataSet.drawFilledEnabled = true
        dataSet.fillAlpha = 0.8
        
        dataSet.label = ""
        dataSet.form = .none
    }
    
    private func setup(_ data: LineChartData) {
        data.setDrawValues(false)
    }
    
    func toggleFavourite(_ coin: Coin) throws {
        if !isFavorite(coin) {
            try favouriteService.add(coin)
            view.show(message: "\(coin.name) добавлен в избранное")
        } else {
            try favouriteService.remove(coin)
            view.show(message: "\(coin.name) удален из избранного")
        }
    }
    
    func isFavorite(_ coin: Coin) -> Bool {
        favouriteService.isFavorite(coin)
    }
}
