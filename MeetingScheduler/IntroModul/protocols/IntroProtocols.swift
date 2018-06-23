//
//  IntroProtocol.swift
//  MeetingScheduler
//

import UIKit

protocol IntroViewProtocol: class {
    var presenter: IntroPresenterProtocol? { get set }
    
    // PRESENTER -> VIEW
    
}

protocol IntroWireFrameProtocol: class {
    
    static func createIntroModule() -> UIViewController
    
    func presentRegisterScreen(from view: IntroViewProtocol)
    func presentLoginScreen(from view: IntroViewProtocol)
    func changeToMainController()

}

protocol IntroPresenterProtocol: class {
    var view: IntroViewProtocol? { get set }
    var interactor: IntroInteractorInputProtocol? { get set }
    var wireFrame: IntroWireFrameProtocol? { get set }
    
    // VIEW -> PRESENTER
    func viewDidLoad()
    func openLoginScreen()
    func openRegisterScreen()
    func switchToMainController()
}

protocol IntroInteractorOutputProtocol: class {
    // INTERACTOR -> PRESENTER
}

protocol IntroInteractorInputProtocol: class {
    var presenter: IntroInteractorOutputProtocol? { get set }
    
    // PRESENTER -> INTERACTOR
}
