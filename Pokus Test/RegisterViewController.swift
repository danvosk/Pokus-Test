//
//  RegisterViewController.swift
//  Pokus Test
//
//  Created by Görkem Karagöz on 14.08.2024.
//

import UIKit
import FirebaseAuth

class RegisterViewController: UIViewController {
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var surnameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func backButton(_ sender: Any) {
        performSegue(withIdentifier: "toMainVc", sender: nil)
    }
    @IBAction func registerButtonTapped(_ sender: Any) {
        if let name = nameTextField.text, !name.isEmpty,
           let surname = surnameTextField.text, !surname.isEmpty,
           let email = emailTextField.text, !email.isEmpty,
           let password = passwordTextField.text, !password.isEmpty {
            
            // Firebase Authentication ile kullanıcı kaydı
            Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                if let error = error {
                    self.showAlert(message: "Hata: \(error.localizedDescription)")
                } else {
                    self.showAlert(message: "Kayıt başarılı!")
                    self.performSegue(withIdentifier: "toMainVc", sender: nil)
                }
            }
        } else {
            showAlert(message: "Lütfen tüm alanları doldurun.")
        }
    }

    
    func showAlert(message: String) {
        let alert = UIAlertController(title: "Bilgi", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Tamam", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}
