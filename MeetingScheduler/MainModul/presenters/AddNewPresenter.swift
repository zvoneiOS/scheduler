//
//  AddNewPresenter.swift
//  MeetingScheduler
//

import UIKit

class AddNewPresenter: AddNewPresenterProtocol {
    var view: AddNewViewProtocol?
    var interactor: AddNewInteractorInputProtocol?
    var wireFrame: AddNewWireFrameProtocol?
    
    func viewDidLoad() {

    }
    
    func timeClicked(selectedHour: Hour, hours: [Hour]) {
        self.interactor?.getAvailableTimes(selectedHour: selectedHour, hours: hours)
    }
    
    func saveClicked(endIndex: Int, startIndex: Int, day: Day, description:String) {
        self.interactor?.uploadTermin(day: day, startIndex: startIndex, endIndex: endIndex, description: description)
    }
    
}

extension AddNewPresenter: AddNewInteractorOutputProtocol{
    
    func terminUpload(success: Bool) {
        if success {
            self.view?.closeView()
        }else{
            self.view?.showError(message: "Upload failed")
        }
    }
    
    func availableTimes(hours: [Hour]) {
        self.view?.showAvailableEndHours(endHours: hours)
    }
    
}
