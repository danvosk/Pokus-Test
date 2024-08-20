//
//  AuthorizeBanksViewController.swift
//  Pokus Test
//
//  Created by Görkem Karagöz on 14.08.2024.
//

import UIKit
import DZNEmptyDataSet

class AuthorizeBanksViewController: UIViewController, DZNEmptyDataSetSource, DZNEmptyDataSetDelegate, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableview: UITableView!
    
    var authorizedBanks: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableview.delegate = self
        tableview.dataSource = self
        
        tableview.emptyDataSetSource = self
        tableview.emptyDataSetDelegate = self
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return authorizedBanks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BankCell", for: indexPath)
        cell.textLabel?.text = authorizedBanks[indexPath.row]
        return cell
    }
    
    
    func title(forEmptyDataSet scrollView: UIScrollView) -> NSAttributedString? {
        let str = "Herhangi bir banka yetkilendirilmedi"
        let attrs = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 18)]
        return NSAttributedString(string: str, attributes: attrs)
    }
    
    func description(forEmptyDataSet scrollView: UIScrollView) -> NSAttributedString? {
        let str = "Yetkilendirilmiş bir banka yok. Lütfen bankaları yetkilendirin."
        let attrs = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14)]
        return NSAttributedString(string: str, attributes: attrs)
    }
    
    func image(forEmptyDataSet scrollView: UIScrollView) -> UIImage? {
        return UIImage(named: "empty_banks") // Boş bir ikon kullanabilirsiniz
    }
    
    func backgroundColor(forEmptyDataSet scrollView: UIScrollView) -> UIColor? {
        return UIColor.white
    }
    
    func emptyDataSetShouldDisplay(_ scrollView: UIScrollView) -> Bool {
        return authorizedBanks.isEmpty
    }
    
    func emptyDataSetShouldAllowTouch(_ scrollView: UIScrollView) -> Bool {
        return true
    }
}
