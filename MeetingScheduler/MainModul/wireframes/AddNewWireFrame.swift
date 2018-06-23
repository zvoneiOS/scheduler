//
//  AddNewWireFrame.swift
//  MeetingScheduler
//

import UIKit

class AddNewWireFrame: AddNewWireFrameProtocol {
    
    static func createAddNewScreen(selectedHour: Hour, day: Day) -> UIViewController {
        let addNewController = MainWireFrame.mainStoryboard.instantiateViewController(withIdentifier: "AddNewVC")
        if let view = addNewController as? AddNewVC {
            view.hour = selectedHour
            view.day = day
            let presenter: AddNewPresenterProtocol & AddNewInteractorOutputProtocol = AddNewPresenter()
            let interactor: AddNewInteractorInputProtocol = AddNewInteractor()
            let wireFrame: AddNewWireFrameProtocol = AddNewWireFrame()
            
            view.presenter = presenter
            presenter.view = view
            presenter.wireFrame = wireFrame
            presenter.interactor = interactor
            interactor.presenter = presenter
            
            return addNewController
        }
        return UIViewController()
    }
    
}
