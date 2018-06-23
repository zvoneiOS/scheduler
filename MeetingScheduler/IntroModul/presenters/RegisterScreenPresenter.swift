//
//  RegisterScreenPresenter.swift
//  MeetingScheduler
//

import Foundation

class RegisterScreenPresenter: RegisterPresenterProtocol {
    
    weak var view: RegisterViewProtocol?
    
    var interactor: RegisterInteractorInputProtocol?
    
    var wireFrame: RegisterWireFrameProtocol?
    
    func viewDidLoad() {
        
    }
    
    func registerClicked(username: String, email: String, password: String) {
        self.interactor?.register(username: username, email: email, password: password)
    }
    
}

extension RegisterScreenPresenter: RegisterInteractorOutputProtocol{
    
    func error(message: String) {
        view?.showError(message: message)
    }
    
    func success() {
        wireFrame?.switchToMainModule(from: view!)
    }
    
}
