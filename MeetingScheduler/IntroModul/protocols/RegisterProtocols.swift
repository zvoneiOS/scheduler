//
//  RegisterProtocols.swift
//  MeetingScheduler
//

import UIKit

protocol RegisterViewProtocol: class {
    var presenter: RegisterPresenterProtocol? { get set }
    
    // PRESENTER -> VIEW
    func showError(message:String)
}

protocol RegisterWireFrameProtocol: class {
    
    static func createRegisterScreen() -> UIViewController
    
    func switchToMainModule(from view: RegisterViewProtocol)

}

protocol RegisterPresenterProtocol: class {
    var view: RegisterViewProtocol? { get set }
    var interactor: RegisterInteractorInputProtocol? { get set }
    var wireFrame: RegisterWireFrameProtocol? { get set }
    
    // VIEW -> PRESENTER
    func viewDidLoad()
    func registerClicked(username:String, email:String, password:String)
}

protocol RegisterInteractorOutputProtocol: class {
    // INTERACTOR -> PRESENTER
    func error(message:String)
    
    func success()

}

protocol RegisterInteractorInputProtocol: class {
    var presenter: RegisterInteractorOutputProtocol? { get set }
    
    // PRESENTER -> INTERACTOR
    func register(username:String, email:String, password:String)

}
