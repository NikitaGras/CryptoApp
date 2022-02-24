//
//  CoinInfoViewController.swift
//  CryptoApp
//
//  Created by Nikita Gras on 21.04.2021.
//

import Charts
import NVActivityIndicatorView
import Toast_Swift

class CoinInfoViewController: UIViewController, CoinInfoInput {
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var selectedDateLabel: UILabel!
    @IBOutlet weak var chartView: LineChartView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var segmentedControl: CustomSegmentedControl!
    @IBOutlet weak var activityIndicator: NVActivityIndicatorView!
    
    let numberFormatter = NumberFormatter.withComma
    let dateFormatter = DateFormatter.shortDate
    var output: CoinInfoOutput!
    var coin: Coin!

    override func viewDidLoad() {
        super.viewDidLoad()
        output = CoinInfoPresenter(self)
        output.viewIsReady()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.popToRootViewController(animated: true)
    }
    
    //MARK: - CoinInfoInput
    func setupinitialState() {
        setupTableView()
        chartView.delegate = self
        selectedDateLabel.isHidden = true
        setupNavigationItem()
        fillDisplay()
        segmentedControl.delegate = self
        setupNavigationView()
    }
    
    func startLoading() {
        chartView.isHidden = true
        activityIndicator.startAnimating()
        segmentedControl.isActive = false
    }
    
    func stopLoading() {
        chartView.isHidden = false
        activityIndicator.stopAnimating()
        segmentedControl.isActive = true
    }
    
    func setupTableView() {
        tableView.register(cell: CoinInfoTableViewCell.self)
        tableView.dataSource = self
        tableView.isScrollEnabled = false
    }
    
    func setupNavigationView() {
        let navView = CoinNavigationHeaderView()
        navView.fill(with: coin)
        navigationItem.titleView = navView
    }
    
    func setupNavigationImage() {
        let imageName = output.isFavorite(coin) ? "filledStar" : "star"
        let favouriteImage = UIImage(named: imageName)
        navigationItem.rightBarButtonItem?.image = favouriteImage
    }
    
    func fillDisplay() {
        let price = coin.price?.commaSeparated() ?? ""
        priceLabel.text = "$ " + price
    }
    
    func setupNavigationItem() {
        let rightButton = UIBarButtonItem(image: nil, style: .plain, target: self, action: #selector(toggleFavourite))
        self.navigationItem.rightBarButtonItem = rightButton
        self.setupNavigationImage()
    }
    
    @objc func toggleFavourite() {
        do {
            try output.toggleFavourite(coin)
            setupNavigationImage()
        } catch {
            show(error)
        }
    }
    
    func setupChartView(with data: LineChartData) {
        chartView.data = data
        chartView.xAxis.enabled = false
        chartView.leftAxis.enabled = false
        chartView.rightAxis.enabled = false
    }
    
    func show(message: String) {
        self.view.makeToast(message, duration: 1.5, position: .bottom)
    }
}

extension CoinInfoViewController: ChartViewDelegate {
    func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) {
        self.selectedDateLabel.isHidden = false
        
        let price = entry.y.commaSeparated()
        self.priceLabel.text = "$ " + price
        
        let date = Date(timeIntervalSince1970: entry.x)
        let dateString = dateFormatter.string(from: date)
        self.selectedDateLabel.text = dateString
    }
}

extension CoinInfoViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let coinInfo = coin.getInfo()
        return coinInfo.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CoinInfoTableViewCell.identifier) as! CoinInfoTableViewCell
        let coinInfo = coin.getInfo()
        cell.fill(with: coinInfo[indexPath.row])
        return cell
    }
}

extension CoinInfoViewController: CustomSegmentedControlDelegate {
    func segmentedControl(_ segmentedControl: CustomSegmentedControl, didSelectSegmentAt index: Int) {
        selectedDateLabel.isHidden = true
        let periods = TimePeriod.getCases()
        let selectedPeriod: TimePeriod = periods[index]
        output.getHistoricalData(for: coin, for: selectedPeriod)
    }
}
