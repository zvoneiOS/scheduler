//
//  RegisterInteractor.swift
//  MeetingScheduler
//
import UIKit
import Firebase
import FirebaseDatabase
import FirebaseAuth

class RegisterInteractor: RegisterInteractorInputProtocol {
    
    weak var presenter: RegisterInteractorOutputProtocol?
    
    var ref: DatabaseReference!

    func register(username: String, email: String, password: String) {
        self.ref = Database.database().reference()
        if checkUsername(username: username) {
            self.ref.child("users").queryOrdered(byChild: "username").queryEqual(toValue: username).observeSingleEvent(of: .value, with: { (snapshot) in
                // Get user value
                let value = snapshot.value as? NSDictionary
                if(value == nil){
                    self.checkEmailAndPasswordAndCreateUser(username: username, email:email, password:password)
                }else{
                    self.presenter?.error(message: "Username taken")
                }
            }) { (error) in
                self.presenter?.error(message: error.localizedDescription)
            }
        }else{
            presenter?.error(message: "Username invalid")
        }
    }
    
    func checkEmailAndPasswordAndCreateUser(username: String, email:String, password:String){
        if email.isValidEmail() {
            if(self.checkPassword(password: password)){
                Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
                    // ...
                    if(error == nil){
                        self.ref = Database.database().reference()
                        self.ref.child("users").child(user!.uid).setValue(["username": username])
                        MeetingUserDefaults.sharedInstance.setUsername(username: username)
                        self.presenter?.success()
                    }else{
                        self.presenter?.error(message: error!.localizedDescription)
                    }
                }
            }else{
                presenter?.error(message: "Password must be larger then 7 characters")
            }
        }else{
            presenter?.error(message: "Email invalid")
        }
    }
    
    func checkPassword(password: String) -> Bool {
        if(password.count > 7){
            return true
        }else{
            return false
        }
    }
    
    func checkUsername(username: String) -> Bool {
        if(username.count > 2){
            return true
        }else{
            return false
        }
    }
}

extension String {
    func isValidEmail() -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: self)
    }
}
