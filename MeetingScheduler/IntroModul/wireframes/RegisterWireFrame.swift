//
//  RegisterWireFrame.swift
//  MeetingScheduler
//

import UIKit

class RegisterWireFrame: RegisterWireFrameProtocol {
    
    static func createRegisterScreen() -> UIViewController {
        let registerController = IntroWireFrame.introStoryboard.instantiateViewController(withIdentifier: "RegisterVC")
        if let view = registerController as? RegisterVC {
            let presenter: RegisterPresenterProtocol & RegisterInteractorOutputProtocol = RegisterScreenPresenter()
            let interactor: RegisterInteractorInputProtocol = RegisterInteractor()
            let wireFrame: RegisterWireFrameProtocol = RegisterWireFrame()
            
            view.presenter = presenter
            presenter.view = view
            presenter.wireFrame = wireFrame
            presenter.interactor = interactor
            interactor.presenter = presenter
            
            return registerController
        }
        return UIViewController()
    }
    
    func switchToMainModule(from view: RegisterViewProtocol) {
        let mainViewController = MainWireFrame.createMainScreen()
        
        if view is UIViewController {
            let transition = CATransition()
            transition.type = kCATransitionFromBottom
            UIApplication.shared.keyWindow?.changeRootViewController(rootViewController: mainViewController, withTransition: transition)
        }
    }
    
}
