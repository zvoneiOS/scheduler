//
//  IntroWireframe.swift
//  MeetingScheduler
//

import UIKit
import FirebaseAuth

class IntroWireFrame: IntroWireFrameProtocol {
    
    static func createIntroModule() -> UIViewController {
        let navController = introStoryboard.instantiateInitialViewController()!
        if let view = navController.childViewControllers.first as? IntroVC {
            let presenter: IntroPresenterProtocol & IntroInteractorOutputProtocol = IntroScreenPresenter()
            let interactor: IntroInteractorInputProtocol = IntroInteractor()
            let wireFrame: IntroWireFrameProtocol = IntroWireFrame()
            
            view.presenter = presenter
            presenter.view = view
            presenter.wireFrame = wireFrame
            presenter.interactor = interactor
            interactor.presenter = presenter
            
            return navController
        }
        return UIViewController()
    }
    
    static var introStoryboard: UIStoryboard {
        return UIStoryboard(name: "Intro", bundle: Bundle.main)
    }
    
    func presentRegisterScreen(from view: IntroViewProtocol){
        let registerViewController = RegisterWireFrame.createRegisterScreen()
        
        if let sourceView = view as? UIViewController {
            sourceView.navigationController?.pushViewController(registerViewController, animated: true)
        }
    }
    
    
    func presentLoginScreen(from view: IntroViewProtocol){
        let loginViewController = LoginWireFrame.createLoginScreen()
        if let sourceView = view as? UIViewController {
            sourceView.navigationController?.pushViewController(loginViewController, animated: true)
        }
    }
    
    func changeToMainController() {
        if(Auth.auth().currentUser != nil){
            let mainScreen = MainWireFrame.createMainScreen()
            let transition = CATransition()
            transition.type = kCATransitionFromBottom
            UIApplication.shared.keyWindow?.changeRootViewController(rootViewController: mainScreen, withTransition: transition)
        }
    }
}
