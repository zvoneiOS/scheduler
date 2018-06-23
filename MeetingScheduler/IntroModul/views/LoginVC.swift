//
//  LoginVC.swift
//  MeetingScheduler
//

import UIKit

class LoginVC: UIViewController {

    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    var presenter:LoginPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter?.viewDidLoad()
        self.emailField.becomeFirstResponder()
    }

    @IBAction func loginClicked(_ sender: Any) {
        if !self.activityIndicator.isAnimating {
            self.activityIndicator.startAnimating()
            self.loginButton.setTitle("", for: .normal)
            self.presenter?.login(email: self.emailField.text!, password: self.passwordField.text!)
        }
    }
}

extension LoginVC: LoginViewProtocol{
    
    func showError(message: String) {
        self.activityIndicator.stopAnimating()
        self.loginButton.setTitle("Login", for: .normal)
        let alert = UIAlertController.init(title: message, message: "", preferredStyle: .alert)
        alert.addAction(UIAlertAction.init(title: "OK", style: .destructive, handler: { (action) in
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    
}
