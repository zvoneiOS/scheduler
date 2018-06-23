//
//  AddNewProtocols.swift
//  MeetingScheduler
//

import UIKit

protocol AddNewViewProtocol: class {
    var presenter: AddNewPresenterProtocol? { get set }
    
    // PRESENTER -> VIEW
    func showError(message:String)
    
    func showAvailableEndHours(endHours:[Hour])
    
    func closeView()
    
}

protocol AddNewWireFrameProtocol: class {
    
    static func createAddNewScreen(selectedHour:Hour, day:Day) -> UIViewController
    
}

protocol AddNewPresenterProtocol: class {
    
    var view: AddNewViewProtocol? { get set }
    var interactor: AddNewInteractorInputProtocol? { get set }
    var wireFrame: AddNewWireFrameProtocol? { get set }
    
    // VIEW -> PRESENTER
    func viewDidLoad()
    
    func timeClicked(selectedHour:Hour, hours:[Hour])
    
    func saveClicked(endIndex:Int, startIndex:Int, day:Day, description:String)
    
}

protocol AddNewInteractorOutputProtocol: class {
    // INTERACTOR -> PRESENTER
    func availableTimes(hours:[Hour])
    
    func terminUpload(success:Bool)
}

protocol AddNewInteractorInputProtocol: class {
    
    var presenter: AddNewInteractorOutputProtocol? { get set }
    
    func getAvailableTimes(selectedHour: Hour, hours:[Hour])
    
    func uploadTermin(day:Day, startIndex:Int, endIndex:Int, description:String)
    
}
