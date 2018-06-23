//
//  LoginWireFrame.swift
//  MeetingScheduler
//

import UIKit

class LoginWireFrame: LoginWireFrameProtocol {
    
    static func createLoginScreen() -> UIViewController {
        let loginController = IntroWireFrame.introStoryboard.instantiateViewController(withIdentifier: "LoginVC")
        if let view = loginController as? LoginVC{
            let presenter:LoginPresenterProtocol & LoginInteractorOutputProtocol = LoginScreenPresenter()
            let interactor:LoginInteractorInputProtocol = LoginInteractor()
            let wireframe:LoginWireFrameProtocol = LoginWireFrame()
            
            view.presenter = presenter
            presenter.view = view
            presenter.interactor = interactor
            presenter.wireFrame = wireframe
            interactor.presenter = presenter
            
            return loginController
        }
        return UIViewController()
    }
    
    func switchToMainModule(from view: LoginViewProtocol) {
        let mainViewController = MainWireFrame.createMainScreen()
        
        if view is UIViewController {
            let transition = CATransition()
            transition.type = kCATransitionFromBottom
            UIApplication.shared.keyWindow?.changeRootViewController(rootViewController: mainViewController, withTransition: transition)
        }
    }
    
}
