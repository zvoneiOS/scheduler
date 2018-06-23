//
//  MainWireFrame.swift
//  MeetingScheduler
//

import UIKit

class MainWireFrame: MainWireFrameProtocol {
    
    func pushAddNewTerminScreen(from view: MainViewProtocol, selectedHour: Hour, day: Day) {
        let addNewController = AddNewWireFrame.createAddNewScreen(selectedHour: selectedHour, day: day)
        if let sourceView = view as? UIViewController {
            sourceView.navigationController?.pushViewController(addNewController, animated: true)
        }
    }
    
    func switchToIntroModule(from view: MainViewProtocol) {
        let introViewController = IntroWireFrame.createIntroModule()
        
        if view is UIViewController {
            let transition = CATransition()
            transition.type = kCATransitionFromBottom
            UIApplication.shared.keyWindow?.changeRootViewController(rootViewController: introViewController, withTransition: transition)
        }
    }
    
    static func createMainScreen() -> UIViewController {
        let navigationController = MainWireFrame.mainStoryboard.instantiateInitialViewController() as! UINavigationController
        let mainController = navigationController.childViewControllers.first!
        if let view = mainController as? MainVC {
            let presenter: MainPresenterProtocol & MainInteractorOutputProtocol = MainScreenPresenter()
            let interactor: MainInteractorInputProtocol = MainInteractor()
            let wireFrame: MainWireFrameProtocol = MainWireFrame()
            
            view.presenter = presenter
            presenter.view = view
            presenter.wireFrame = wireFrame
            presenter.interactor = interactor
            interactor.presenter = presenter
            
            return navigationController
        }
        return UIViewController()
    }
    
    static var mainStoryboard: UIStoryboard {
        return UIStoryboard(name: "Main", bundle: Bundle.main)
    }
    
}

