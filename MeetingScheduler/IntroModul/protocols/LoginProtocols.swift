//
//  LoginProtocols.swift
//  MeetingScheduler
//

import UIKit

protocol LoginViewProtocol:class {
    var presenter: LoginPresenterProtocol? { get set }
    
    func showError(message:String)
    
}

protocol LoginWireFrameProtocol:class {
    
    static func createLoginScreen() -> UIViewController
    
    func switchToMainModule(from view: LoginViewProtocol)
    
}

protocol LoginPresenterProtocol:class {
    
    var view: LoginViewProtocol? { get set }
    var interactor: LoginInteractorInputProtocol? { get set }
    var wireFrame: LoginWireFrameProtocol? { get set }
    
    func viewDidLoad()
    
    func login(email:String, password:String)
    
}


protocol LoginInteractorOutputProtocol:class {
    
    func error(message:String)
    
    func success()
    
}
 
protocol LoginInteractorInputProtocol:class {
    var presenter: LoginInteractorOutputProtocol? { get set }
    
    func login(email:String, password:String)
}


