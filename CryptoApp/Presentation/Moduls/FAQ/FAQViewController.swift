//
//  FAQViewController.swift
//  CryptoApp
//
//  Created by Nikita Gras on 19.05.2021.
//

import UIKit


class FAQViewController: UIViewController, FAQViewInput {
    @IBOutlet weak var tableView: UITableView!
    
    var output: FAQViewOutput!
    var displayManager: FAQDisplayManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        displayManager = FAQDisplayManager(tableView)
        output = FAQPresenter(self)
        output.viewIsReady()
    }
}
