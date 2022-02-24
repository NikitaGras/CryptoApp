//
//  CoinsViewController.swift
//  CryptoApp
//
//  Created by Nikita Gras on 16.04.2021.
//

import NVActivityIndicatorView

class CoinsViewController: UIViewController, CoinsViewInput {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicator: NVActivityIndicatorView!
    @IBOutlet weak var retryButton: UIButton!
    @IBOutlet weak var emptySearchLabel: UILabel!
    var searchController: UISearchController!

    var output: CoinsViewOutput!
    var displayManager: CoinsDisplayManager!
    
    var selectedCoin: Coin?
    var coins = [Coin]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        output = CoinsPresenter(self)
        output.viewIsReady()
    }
    
    deinit {
        removeNotificationCenter()
    }
    
    //MARK: - CoinsViewInput
    func setupInitialState() {
        displayManager = CoinsDisplayManager(tableView)
        self.navigationItem.backButtonTitle = ""
        emptySearchLabel.isHidden = true
        displayManager.delegate = self
        displayManager.isEditableRow = false
        setupSearchController()
        addNotificationCenter()
    }
    
    func setupSearchController() {
        searchController = UISearchController(searchResultsController: nil)
        searchController.dimsBackgroundDuringPresentation = false
        searchController.searchResultsUpdater = self
        searchController.hidesNavigationBarDuringPresentation = true
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = true
    }
    
    func startLoading() {
        tableView.isHidden = true
        retryButton.isHidden = true
        navigationItem.searchController?.searchBar.isHidden = true
        activityIndicator.startAnimating()
    }
    
    func stopLoading() {
        retryButton.isHidden = false
        navigationItem.searchController?.searchBar.isHidden = false
        activityIndicator.stopAnimating()
    }
    
    func didLoadData(_ coins: [Coin]) {
        tableView.isHidden = false
        retryButton.isHidden = true
        self.coins = coins
        displayManager.set(coins)
    }
    
    @IBAction func retry(_ sender: Any) {
        output.getCoins()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? CoinInfoViewController, let coin = selectedCoin {
            vc.coin = coin
        }
    }
    
    func showSearchResult(_ coins: [Coin]) {
        displayManager.set(coins)
        if coins.isEmpty {
            emptySearchLabel.isHidden = false
        } else {
            emptySearchLabel.isHidden = true
        }
    }
}

extension CoinsViewController: CoinsDisplaymanagerDelegate {
    func displayManager(_ displayManager: CoinsDisplayManager, didSelectCoin coin: Coin) {
        self.selectedCoin = coin
        performSegue(withIdentifier: "showInfo", sender: nil)
    }
    
    func displayManager(_ displayManager: CoinsDisplayManager, deleteCoin coin: Coin) {}
}

extension CoinsViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let searchText = searchController.searchBar.text?.lowercased() ?? ""
        output.updateSearchResult(with: searchText)
    }
}

// MARK: - Keyboard
extension CoinsViewController {
    func addNotificationCenter() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShown(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func removeNotificationCenter() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillShown(_ notification: Notification) {
        let info = notification.userInfo
        let frame = info?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect
        let tabBarHeight = tabBarController?.tabBar.frame.height ?? 0
        if let frame = frame {
            tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: frame.height - tabBarHeight, right: 0)
        }
    }
    
    @objc func keyboardWillHide(_ notification: Notification) {
        tableView.contentInset = .zero
    }
}
