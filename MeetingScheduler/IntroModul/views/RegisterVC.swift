//
//  RegisterVC.swift
//  MeetingScheduler
//

import UIKit

class RegisterVC: UIViewController {
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextFIeld: UITextField!
    @IBOutlet weak var registerButton: UIButton!
    
    var presenter: RegisterPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter?.viewDidLoad()
        self.usernameTextField.becomeFirstResponder()
        self.navigationItem.title = "Register"
    }
    
    @IBAction func registerButtonClicked(_ sender: Any) {
        if !self.activityIndicator.isAnimating {
            self.activityIndicator.startAnimating()
            self.registerButton.setTitle("", for: .normal)
            self.presenter?.registerClicked(username: self.usernameTextField.text!, email: self.emailTextField.text!, password: self.passwordTextFIeld.text!)
        }
        
    }
    
}

extension RegisterVC: RegisterViewProtocol{
    
    func showError(message: String) {
        self.activityIndicator.stopAnimating()
        self.registerButton.setTitle("Register", for: .normal)
        let alert = UIAlertController.init(title: message, message: "", preferredStyle: .alert)
        alert.addAction(UIAlertAction.init(title: "OK", style: .destructive, handler: { (action) in
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
}
