//
//  AuthorizeBanksViewController.swift
//  Pokus Test
//
//  Created by Görkem Karagöz on 14.08.2024.
//
//
//import UIKit
//import FirebaseAuth
//import FirebaseFirestore
//import DZNEmptyDataSet
//
//class AuthorizeBanksViewController: UIViewController, DZNEmptyDataSetSource, DZNEmptyDataSetDelegate, UITableViewDelegate, UITableViewDataSource {
//    
//    @IBOutlet weak var tableview: UITableView!
//    @IBOutlet weak var indicatorView: UIActivityIndicatorView!
//    
//    var authorizedBanks: [(id: Int, accountName: String)] = []
//    var isLoading = true
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        tableview.delegate = self
//        tableview.dataSource = self
//        
//        tableview.emptyDataSetSource = self
//        tableview.emptyDataSetDelegate = self
//        
//        fetchAuthorizedBanks()
//    }
//    
//    func fetchAuthorizedBanks() {
//        indicatorView.startAnimating()
//        indicatorView.isHidden = false
//        isLoading = true
//        
//        guard let userId = Auth.auth().currentUser?.uid else {
//            self.isLoading = false
//            self.updateTableView()
//            return
//        }
//        
//        let db = Firestore.firestore()
//        db.collection("users").document(userId).getDocument { (document, error) in
//            if let document = document, document.exists {
//                if let authorizeBanks = document.data()?["AuthorizeBanks"] as? [[String: Any]] {
//                    self.authorizedBanks = authorizeBanks.compactMap { bank in
//                        if let id = bank["id"] as? Int, let accountName = bank["accountName"] as? String {
//                            return (id: id, accountName: accountName)
//                        }
//                        return nil
//                    }
//                }
//            } else {
//                print("Error fetching authorized banks: \(error?.localizedDescription ?? "No error description available.")")
//            }
//            
//            self.isLoading = false
//            DispatchQueue.main.async {
//                self.updateTableView()
//            }
//        }
//    }
//    
//    func updateTableView() {
//        tableview.reloadData()
//        indicatorView.stopAnimating()
//        indicatorView.isHidden = true
//    }
//    
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return authorizedBanks.count
//    }
//    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        tableView.deselectRow(at: indexPath, animated: true)
//    }
//    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "BankCell", for: indexPath)
//        let bank = authorizedBanks[indexPath.row]
//        let bankName = getBankNameById(bank.id) // Banka adını almak için
//        
//        var content = cell.defaultContentConfiguration()
//        content.text = bankName
//        content.secondaryText = bank.accountName
//        cell.contentConfiguration = content
//        return cell
//    }
//    
//    // Hücreyi yana kaydırarak silme işlemi
//    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
//        if editingStyle == .delete {
//            let bankToDelete = authorizedBanks[indexPath.row]
//            authorizedBanks.remove(at: indexPath.row)
//            
//            guard let userId = Auth.auth().currentUser?.uid else { return }
//            let db = Firestore.firestore()
//            
//            db.collection("users").document(userId).updateData([
//                "AuthorizeBanks": FieldValue.arrayRemove([["id": bankToDelete.id, "accountName": bankToDelete.accountName]])
//            ]) { error in
//                if let error = error {
//                    print("Error removing bank info: \(error)")
//                } else {
//                    DispatchQueue.main.async {
//                        self.updateTableView()
//                    }
//                }
//            }
//        }
//    }
//    
//
//
//    
//    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
//        return "Kaldır"
//    }
//    
//    func getBankNameById(_ id: Int) -> String {
//        let bankNames = [
//            0: "Akbank",
//            1: "Garanti",
//            2: "DenizBank",
//            3: "Pokus",
//            4: "Ziraat Bankası"
//        ]
//        return bankNames[id] ?? "Bilinmeyen Banka"
//    }
//    
//    func title(forEmptyDataSet scrollView: UIScrollView) -> NSAttributedString? {
//        let str = "Herhangi bir banka yetkilendirilmedi"
//        let attrs = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 18)]
//        return NSAttributedString(string: str, attributes: attrs)
//    }
//    
//    func description(forEmptyDataSet scrollView: UIScrollView) -> NSAttributedString? {
//        let str = "Yetkilendirilmiş bir banka yok. Lütfen bankaları yetkilendirin."
//        let attrs = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14)]
//        return NSAttributedString(string: str, attributes: attrs)
//    }
//    
//    func image(forEmptyDataSet scrollView: UIScrollView) -> UIImage? {
//        return UIImage(named: "empty_banks") // Boş bir ikon kullanabilirsiniz
//    }
//    
//    func backgroundColor(forEmptyDataSet scrollView: UIScrollView) -> UIColor? {
//        return UIColor.white
//    }
//    
//    func emptyDataSetShouldDisplay(_ scrollView: UIScrollView) -> Bool {
//        return !isLoading && authorizedBanks.isEmpty
//    }
//    
//    func emptyDataSetShouldAllowTouch(_ scrollView: UIScrollView) -> Bool {
//        return true
//    }
//}
import UIKit
import FirebaseAuth
import FirebaseFirestore
import DZNEmptyDataSet

class AuthorizeBanksViewController: UIViewController, DZNEmptyDataSetSource, DZNEmptyDataSetDelegate, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableview: UITableView!
       @IBOutlet weak var indicatorView: UIActivityIndicatorView!
       
       var authorizedBanks: [(id: Int, accountName: String)] = []
       var isLoading = true
       
       var openedFromAkbankTest: Bool = false
       var openedFromGarantiTest: Bool = false

       override func viewDidLoad() {
           super.viewDidLoad()
           
           tableview.delegate = self
           tableview.dataSource = self
           tableview.emptyDataSetSource = self
           tableview.emptyDataSetDelegate = self
           
           fetchAuthorizedBanks()
       }
       
       func fetchAuthorizedBanks() {
           indicatorView.startAnimating()
           indicatorView.isHidden = false
           isLoading = true
           
           guard let userId = Auth.auth().currentUser?.uid else {
               self.isLoading = false
               self.updateTableView()
               return
           }
           
           let db = Firestore.firestore()
           db.collection("users").document(userId).getDocument { (document, error) in
               if let document = document, document.exists {
                   if let authorizeBanks = document.data()?["AuthorizeBanks"] as? [[String: Any]] {
                       self.authorizedBanks = authorizeBanks.compactMap { bank in
                           if let id = bank["id"] as? Int, let accountName = bank["accountName"] as? String {
                               return (id: id, accountName: accountName)
                           }
                           return nil
                       }
                   }
               } else {
                   print("Error fetching authorized banks: \(error?.localizedDescription ?? "No error description available.")")
               }
               
               self.isLoading = false
               DispatchQueue.main.async {
                   self.updateTableView()
               }
           }
       }
       
       func updateTableView() {
           tableview.reloadData()
           indicatorView.stopAnimating()
           indicatorView.isHidden = true
       }
       
       func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
           return authorizedBanks.count
       }
       
       func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
           tableView.deselectRow(at: indexPath, animated: true)
       }
       
       func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           let cell = tableView.dequeueReusableCell(withIdentifier: "BankCell", for: indexPath)
           let bank = authorizedBanks[indexPath.row]
           let bankName = getBankNameById(bank.id)
           
           var content = cell.defaultContentConfiguration()
           content.text = bankName
           content.secondaryText = bank.accountName
           cell.contentConfiguration = content
           return cell
       }
       
       func getBankNameById(_ id: Int) -> String {
           let bankNames = [
               0: "Akbank",
               1: "Garanti",
               2: "DenizBank",
               3: "Pokus",
               4: "Ziraat Bankası"
           ]
           return bankNames[id] ?? "Bilinmeyen Banka"
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
        return !isLoading && authorizedBanks.isEmpty
    }
    
    func emptyDataSetShouldAllowTouch(_ scrollView: UIScrollView) -> Bool {
        return true
    }
}
