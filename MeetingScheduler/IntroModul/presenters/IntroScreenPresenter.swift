//
//  IntroScreenProtocol.swift
//  MeetingScheduler
//

import Foundation

class IntroScreenPresenter: IntroPresenterProtocol {
    
    weak var view: IntroViewProtocol?
    var interactor: IntroInteractorInputProtocol?
    var wireFrame: IntroWireFrameProtocol?
    
    func viewDidLoad() {
        
    }
    
    func openLoginScreen() {
        self.wireFrame?.presentLoginScreen(from: view!)
    }
    
    func openRegisterScreen() {
        self.wireFrame?.presentRegisterScreen(from: view!)
    }
    
    func switchToMainController() {
        self.wireFrame?.changeToMainController()
    }
    
}

extension IntroScreenPresenter: IntroInteractorOutputProtocol{
    
}
