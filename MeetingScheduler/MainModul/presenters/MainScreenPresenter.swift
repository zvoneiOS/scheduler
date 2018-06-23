//
//  MainScreenPresenter.swift
//  MeetingScheduler
//

import Foundation

let numberOfUpcomingWeeks = 4

class MainScreenPresenter: MainPresenterProtocol {
    
    weak var view: MainViewProtocol?
    var interactor: MainInteractorInputProtocol?
    var wireFrame: MainWireFrameProtocol?
    
    func viewDidLoad() {
        self.setupDates()
    }
    
    func logout() {
        self.interactor?.logoutUser()
    }
    
    func setupDates(){
        var days = [Day]()
        for index in 0...numberOfUpcomingWeeks * 7 - 1 {
            let date = Calendar.current.date(byAdding: .day, value: index, to: Date())
            let day = Day.init(date: date!)
            days.append(day)
        }
        self.interactor?.fetchDaysAndFilterThem(days: days)
    }
    
    func openTakeTerminScreen(hour: Hour, day: Day) {
        self.wireFrame?.pushAddNewTerminScreen(from: self.view!, selectedHour: hour, day: day)
    }
    func deleteTermin(hour: Hour, day: Day){
        self.interactor?.deleteTermin(hour: hour, day: day)
    }
    func openDescription(description: String, username: String, hour: Hour, day: Day) {
        self.view?.openDescription(description: description, username: username, hour: hour, day: day)
    }
    
}

extension MainScreenPresenter: MainInteractorOutputProtocol{
    
    func daysFetched(days: [Day]) {
        self.view?.setupDays(days: days)
    }
    
    func loggedOut() {
        self.wireFrame?.switchToIntroModule(from: self.view!)
    }
    
}
