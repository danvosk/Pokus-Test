//
//  ViewController.swift
//  Pokus Test
//
//  Created by Görkem Karagöz on 14.08.2024.

import UIKit
import FirebaseAuth

class ViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    var openedFromAkbankTest: Bool = false
    var userEmailFromAkbank: String? // Akbank Test'ten gelen email adresini saklayacak
    
    override func viewDidLoad() {
        super.viewDidLoad()
        passwordTextField.isSecureTextEntry = true
    }

    @IBAction func loginButtonTapped(_ sender: Any) {
        guard let email = emailTextField.text, !email.isEmpty,
              let password = passwordTextField.text, !password.isEmpty else {
            showAlert(message: "Lütfen e-posta ve şifre alanlarını doldurun.")
            return
        }
        
        // Eğer Akbank'tan geldiyse ve email adresleri uyuşmuyorsa giriş yapmayı engelle
        if openedFromAkbankTest, let userEmailFromAkbank = userEmailFromAkbank, email != userEmailFromAkbank {
            showAlert(message: "Girdiğiniz e-posta, Akbank uygulamasındaki e-posta ile uyuşmuyor. Giriş yapılamıyor.")
            return
        }

        // Firebase Authentication ile kullanıcı girişi
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            if let error = error {
                self.showAlert(message: "Giriş başarısız: \(error.localizedDescription)")
            } else {
                if self.openedFromAkbankTest {
                    self.performSegue(withIdentifier: "toAuthorizeVc", sender: nil)
                } else {
                    self.performSegue(withIdentifier: "toOtherBanksScreenVC", sender: nil)
                }
            }
        }
    }
    
    @IBAction func registerButtonTapped(_ sender: Any) {
        performSegue(withIdentifier: "toRegisterVC", sender: nil)
    }
    
    func showAlert(message: String) {
        let alert = UIAlertController(title: "Bilgi", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Tamam", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}
