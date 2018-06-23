//
//  LoginInteractor.swift
//  MeetingScheduler
//

import Foundation
import Firebase
import FirebaseDatabase
import FirebaseAuth

class LoginInteractor: LoginInteractorInputProtocol{
    
    weak var presenter:LoginInteractorOutputProtocol?
    var ref: DatabaseReference!
    
    func login(email:String, password:String) {
        if email.isValidEmail() {
            if(self.checkPassword(password: password)){
                Auth.auth().signIn(withEmail: email, password: password, completion: { (user, error) in
                    if(error == nil){
                        self.getUsername()
                    }else{
                        self.presenter?.error(message: error!.localizedDescription)
                    }
                })
            }else{
                presenter?.error(message: "Password must be larger then 7 characters")
            }
        }else{
            presenter?.error(message: "Email invalid")
        }
    }
    
    func getUsername(){
        self.ref = Database.database().reference()
        
        self.ref.child("users").child(Auth.auth().currentUser!.uid).observeSingleEvent(of: .value) { (snapshot) in
            
            let value = snapshot.value as? NSDictionary
            if(value != nil){
                if(value!["username"] != nil){
                    MeetingUserDefaults.sharedInstance.setUsername(username: value!["username"] as! String)
                    self.presenter?.success()
                }else{
                    self.presenter?.error(message: "Can't find username")
                }
            }else{
                self.presenter?.error(message: "Can't find username")
            }
        }
    }
    
    func checkPassword(password: String) -> Bool {
        if(password.count > 7){
            return true
        }else{
            return false
        }
    }
}
