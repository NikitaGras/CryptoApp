//
//  FavoriteViewController.swift
//  CryptoApp
//
//  Created by Nikita Gras on 07.05.2021.
//

import UIKit

class FavouriteViewController: UIViewController, FavoriteViewInput {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var retryButton: UIButton!
    @IBOutlet weak var emptyLabel: UILabel!
    
    var displayManager: CoinsDisplayManager!
    var output: FavoriteViewOutput!
    var selectedCoin: Coin?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        output = FavoritePresenter(self)
        displayManager = CoinsDisplayManager(tableView)
        output.viewIsReady()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        output.getCoins()
    }
    
    // MARK: - FavouriteViewInput
    func setupInitialState() {
        activityIndicator.hidesWhenStopped = true
        displayManager.delegate = self
        displayManager.isEditableRow = true
    }
    
    func startLoading() {
        activityIndicator.startAnimating()
        retryButton.isHidden = true
        tableView.isHidden = true
        emptyLabel.isHidden = true
    }
    
    func stopLoading() {
        activityIndicator.stopAnimating()
        retryButton.isHidden = false
        emptyLabel.isHidden = true
    }
    
    func didLoadData(_ coins: [Coin]) {
        tableView.isHidden = false
        retryButton.isHidden = true
        emptyLabel.isHidden = true
        displayManager.set(coins)
    }
    
    func showEmptyLabel() {
        tableView.isHidden = true
        retryButton.isHidden = true
        emptyLabel.isHidden = false
    }
    
    @IBAction func retry(_ sender: Any) {
        output.getCoins()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? CoinInfoViewController, let coin = selectedCoin {
            self.navigationItem.backButtonTitle = ""
            vc.coin = coin
        }
    }
}

extension FavouriteViewController: CoinsDisplaymanagerDelegate {
    func displayManager(_ displayManager: CoinsDisplayManager, didSelectCoin coin: Coin) {
        self.selectedCoin = coin
        performSegue(withIdentifier: "showInfo", sender: nil)
    }
    
    func displayManager(_ displayManager: CoinsDisplayManager, deleteCoin coin: Coin) {
        output.deleteFavourite(coin)
    }
}
