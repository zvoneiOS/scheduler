//
//  MainProtocols.swift
//  MeetingScheduler
//

import UIKit

protocol MainViewProtocol: class {
    var presenter: MainPresenterProtocol? { get set }
    
    // PRESENTER -> VIEW
    func showError(message:String)
    
    func setupDays(days:[Day])
    
    func openDescription(description:String, username:String, hour: Hour, day: Day)

}

protocol MainWireFrameProtocol: class {
    
    static func createMainScreen() -> UIViewController
    
    func switchToIntroModule(from view: MainViewProtocol)
    
    func pushAddNewTerminScreen(from view: MainViewProtocol, selectedHour:Hour, day:Day)
}

protocol MainPresenterProtocol: class {
    var view: MainViewProtocol? { get set }
    var interactor: MainInteractorInputProtocol? { get set }
    var wireFrame: MainWireFrameProtocol? { get set }
    
    // VIEW -> PRESENTER
    func viewDidLoad()
    
    func logout()
    
    func openTakeTerminScreen(hour:Hour, day:Day)
    
    func openDescription(description:String, username:String, hour:Hour, day:Day)
    
    func deleteTermin(hour: Hour, day: Day)

}

protocol MainInteractorOutputProtocol: class {
    // INTERACTOR -> PRESENTER
    func loggedOut()
    
    func daysFetched(days:[Day])
}

protocol MainInteractorInputProtocol: class {
    var presenter: MainInteractorOutputProtocol? { get set }
    
    func logoutUser()
    
    func fetchDaysAndFilterThem(days:[Day])

    func deleteTermin(hour: Hour, day: Day)
}
