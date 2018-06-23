//
//  LoginScreenPresenter.swift
//  MeetingScheduler
//

import Foundation

class LoginScreenPresenter: LoginPresenterProtocol {
    
    
    weak var view : LoginViewProtocol?
    
    var wireFrame: LoginWireFrameProtocol?
    
    var interactor: LoginInteractorInputProtocol?
    
    func viewDidLoad() {
        
    }
    
    func login(email: String, password: String) {
        self.interactor?.login(email: email, password: password)
    }
    
}

extension LoginScreenPresenter: LoginInteractorOutputProtocol{
    
    func error(message: String) {
        self.view?.showError(message: message)
    }
    
    func success() {
        self.wireFrame?.switchToMainModule(from: self.view!)
    }
    
}
