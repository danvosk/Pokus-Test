//
//  AuthorizeViewController.swift
//  Pokus Test
//
//  Created by Görkem Karagöz on 14.08.2024.
//

import UIKit

class AuthorizeViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
  
    @IBOutlet weak var tableView: UITableView!
    
    let accounts = ["Vaadesiz TL", "Vaadesiz EUR", "Vaadesiz USD"]

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self

    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return accounts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = accounts[indexPath.row]
        return cell
    }
    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let selectedAccount = accounts[indexPath.row]
//        print("\(selectedAccount) seçildi")
//
//        // Example 7'ye geri dönmek için URL scheme kullanımı
//        let customUrl = "akbanktestScheme://?selectedAccount=\(selectedAccount)"
//        if let url = URL(string: customUrl) {
//            if UIApplication.shared.canOpenURL(url) {
//                UIApplication.shared.open(url, options: [:], completionHandler: nil)
//            } else {
//                print("Akbank Test app schema not found")
//            }
//        }
//
//        tableView.deselectRow(at: indexPath, animated: true)
//    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedAccount = accounts[indexPath.row]
        print("\(selectedAccount) seçildi")

        // Akbank Test uygulamasına geri dönmek için URL scheme kullanımı
        let customUrl = "akbanktestScheme://?selectedAccount=\(selectedAccount)"
        if let url = URL(string: customUrl.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "") {
            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            } else {
                print("Akbank Test app schema not found")
            }
        }

        tableView.deselectRow(at: indexPath, animated: true)
    }

}
