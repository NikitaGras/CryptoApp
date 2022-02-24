//
//  DocumentsViewController.swift
//  CryptoApp
//
//  Created by Nikita Gras on 16.06.2021.
//

import UIKit

class DocumentsViewController: UIViewController, DocumentsViewInput {
    @IBOutlet weak var tableView: UITableView!
    var output: DocumentsViewOutput!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        output = DocumentsViewPresenter(self)
        output.viewIsReady()
    }
    
    func setupInitialState() {
        tableView.rowHeight = 50
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(cell: DocumentsTableViewCell.self)
    }
}

extension DocumentsViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return output.documents.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let numberOfRows = output.documents[section].count
        return numberOfRows
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let view = view as? UITableViewHeaderFooterView
        view?.textLabel?.font = UIFont.systemFont(ofSize: 20)
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let view = UIView()
        return view
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let title = output.documents[section].first?.type.description
        return title
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = DocumentsTableViewCell.identifier
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier) as! DocumentsTableViewCell
        let document = output.documents[indexPath.section][indexPath.row]
        cell.fill(with: document)
        return cell
    }
}

extension DocumentsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        output.openLink()
    }
}
