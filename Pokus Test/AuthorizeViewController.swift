//
//  AuthorizeViewController.swift
//  Pokus Test
//
//  Created by Görkem Karagöz on 14.08.2024.
//
//import UIKit
//import FirebaseAuth
//import FirebaseFirestore
//
//class AuthorizeViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
//  
//    @IBOutlet weak var tableView: UITableView!
//    
//    let accounts = ["Vadesiz TL", "Vadesiz EUR", "Vadesiz USD"]
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        tableView.delegate = self
//        tableView.dataSource = self
//    }
//    
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return accounts.count
//    }
//    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = UITableViewCell()
//        cell.textLabel?.text = accounts[indexPath.row]
//        return cell
//    }
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let selectedAccount = accounts[indexPath.row]
//        print("\(selectedAccount) seçildi")
//
//        guard let userId = Auth.auth().currentUser?.uid else { return }
//        let db = Firestore.firestore()
//        
//        let userRef = db.collection("users").document(userId)
//        
//        // Önce kullanıcının var olup olmadığını kontrol et
//        userRef.getDocument { (document, error) in
//            if let document = document, document.exists {
//                // Eğer kullanıcı zaten varsa, `AuthorizeBanks` dizisini güncelle
//                self.updateAuthorizeBanks(userRef: userRef, selectedAccount: selectedAccount)
//            } else {
//                // Kullanıcı yoksa yeni bir belge oluştur
//                userRef.setData([
//                    "AuthorizeBanks": [
//                        ["id": 0, "accountName": selectedAccount]  // Burada `id` Akbank'ın ID'si olmalı (0)
//                    ]
//                ]) { error in
//                    if let error = error {
//                        print("Error creating user document: \(error)")
//                    } else {
//                        print("User document created with AuthorizeBanks.")
//                        self.openAkbankTestApp(with: selectedAccount)
//                    }
//                }
//            }
//        }
//        
//        tableView.deselectRow(at: indexPath, animated: true)
//    }
//
//    // `AuthorizeBanks` dizisini güncelleyen fonksiyon
//    func updateAuthorizeBanks(userRef: DocumentReference, selectedAccount: String) {
//        userRef.updateData([
//            "AuthorizeBanks": FieldValue.arrayUnion([
//                ["id": 0, "accountName": selectedAccount]  // Burada `id` Akbank'ın ID'si olmalı (0)
//            ])
//        ]) { error in
//            if let error = error {
//                print("Error updating authorized banks: \(error)")
//            } else {
//                print("Bank successfully authorized.")
//                self.openAkbankTestApp(with: selectedAccount)
//            }
//        }
//    }
//
//    // Akbank Test uygulamasını açan fonksiyon
//    func openAkbankTestApp(with selectedAccount: String) {
//        let customUrl = "akbanktestScheme://?selectedAccount=\(selectedAccount)"
//        if let url = URL(string: customUrl.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "") {
//            if UIApplication.shared.canOpenURL(url) {
//                UIApplication.shared.open(url, options: [:], completionHandler: nil)
//            } else {
//                print("Akbank Test app schema not found")
//            }
//        }
//    }
//}

import UIKit
import FirebaseAuth
import FirebaseFirestore

class AuthorizeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
  
    @IBOutlet weak var tableView: UITableView!
    
    let accounts = ["Vadesiz TL", "Vadesiz EUR", "Vadesiz USD"]
    
    var openedFromAkbankTest: Bool = false
    var openedFromGarantiTest: Bool = false

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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedAccount = accounts[indexPath.row]
        print("\(selectedAccount) seçildi")
        
        guard let userId = Auth.auth().currentUser?.uid else { return }
        let db = Firestore.firestore()
        let userRef = db.collection("users").document(userId)
        
        // Kullanıcının var olup olmadığını kontrol et
        userRef.getDocument { (document, error) in
            if let document = document, document.exists {
                // Kullanıcı varsa yetkilendirme işlemini güncelle
                self.updateAuthorizeBanks(userRef: userRef, selectedAccount: selectedAccount)
            } else {
                // Kullanıcı yoksa yeni bir belge oluştur
                userRef.setData([
                    "AuthorizeBanks": [
                        ["id": self.openedFromAkbankTest ? 0 : 1 , "accountName": selectedAccount] // Akbank: 0, Garanti: 1
                    ]
                ]) { error in
                    if let error = error {
                        print("Error creating user document: \(error)")
                    } else {
                        print("User document created with AuthorizeBanks.")
                        self.openBankApp(with: selectedAccount)
                    }
                }
            }
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
    }

    // `AuthorizeBanks` dizisini güncelleyen fonksiyon
    func updateAuthorizeBanks(userRef: DocumentReference, selectedAccount: String) {
        let bankId = openedFromAkbankTest ? 0 : 1 // Akbank: 0, Garanti: 1
        userRef.updateData([
            "AuthorizeBanks": FieldValue.arrayUnion([
                ["id": bankId, "accountName": selectedAccount]
            ])
        ]) { error in
            if let error = error {
                print("Error updating authorized banks: \(error)")
            } else {
                print("Bank successfully authorized.")
                self.openBankApp(with: selectedAccount)
            }
        }
    }

    // Akbank veya Garanti uygulamasını açan fonksiyon
    func openBankApp(with selectedAccount: String) {
        let customUrl = openedFromAkbankTest ? "akbanktestScheme://?selectedAccount=\(selectedAccount)" : "garantitestSchemes://?selectedAccount=\(selectedAccount)"
        if let url = URL(string: customUrl.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "") {
            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            } else {
                print("Bank app schema not found")
            }
        }
    }
}
