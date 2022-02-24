//
//  FAQDisplayManager.swift
//  CryptoApp
//
//  Created by Nikita Gras on 29.06.2021.
//

import UIKit

class FAQDisplayManager: NSObject {
    private var tableView: UITableView
    private var questions = [FAQ]()
    
    init(_ tableView: UITableView) {
        self.tableView = tableView
        super.init()
        setupTableView()
    }
    
    func setupTableView() {
        tableView.register(cell: FAQTableViewCell.self)
        tableView.estimatedRowHeight = UITableView.automaticDimension
        tableView.rowHeight = UITableView.automaticDimension
        tableView.separatorStyle = .none
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    func set(_ questions: [FAQ]) {
        self.questions = questions
        tableView.reloadData()
    }
}

extension FAQDisplayManager: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return questions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = FAQTableViewCell.identifier
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! FAQTableViewCell
        cell.fill(with: questions[indexPath.row])
        return cell
    }
}

extension FAQDisplayManager: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) as? FAQTableViewCell {
//            tableView.deselectRow(at: indexPath, animated: false)
            tableView.beginUpdates()
            cell.changeNumberOfLines() {
                tableView.endUpdates()
            }
        }
    }
}
