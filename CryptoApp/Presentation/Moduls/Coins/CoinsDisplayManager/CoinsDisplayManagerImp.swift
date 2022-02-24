//
//  CoinsDisplayManagerImp.swift
//  CryptoApp
//
//  Created by Nikita Gras on 17.04.2021.
//

import UIKit

class CoinsDisplayManager: NSObject {
    var tableView: UITableView
    weak var delegate: CoinsDisplaymanagerDelegate?
    let identifier = CoinsTableViewCell.identifier
    
    var coins = [Coin]()
    var isEditableRow = false
    
    init(_ tableView: UITableView) {
        self.tableView = tableView
        super.init()
        setupTableView()
    }
    
    func setupTableView() {
        tableView.register(cell: CoinsTableViewCell.self)
        tableView.rowHeight = 70
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    func set(_ coins: [Coin]) {
        self.coins = coins
        tableView.reloadData()
    }
}

extension CoinsDisplayManager: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return coins.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier) as! CoinsTableViewCell
        cell.fill(with: coins[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return isEditableRow
    }
}

extension CoinsDisplayManager: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let coin = coins[indexPath.row]
        delegate?.displayManager(self, didSelectCoin: coin)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 1
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            delegate?.displayManager(self, deleteCoin: coins[indexPath.row])
            coins.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .middle)
        }
    }
}
