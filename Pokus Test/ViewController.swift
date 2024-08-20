//
//  ViewController.swift
//  Pokus Test
//
//  Created by Görkem Karagöz on 14.08.2024.
//

import UIKit
import FirebaseAuth

class ViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
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
        
        // Firebase Authentication ile kullanıcı girişi
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            if let error = error {
                self.showAlert(message: "Giriş başarısız: \(error.localizedDescription)")
            } else {
                self.performSegue(withIdentifier: "toOtherBanksScreenVC", sender: nil)
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
