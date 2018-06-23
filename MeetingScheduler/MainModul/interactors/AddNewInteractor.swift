//
//  AddNewInteractor.swift
//  MeetingScheduler
//

import UIKit
import FirebaseDatabase

class AddNewInteractor: AddNewInteractorInputProtocol {
    
    var ref: DatabaseReference!
    var presenter: AddNewInteractorOutputProtocol?
    
    func getAvailableTimes(selectedHour: Hour, hours:[Hour]) {
        var endHours = [Hour]()
        var jumped = false
        for hour in hours {
            if(hour.index >= selectedHour.index){
                if(!hour.taken){
                    endHours.append(hour)
                }else{
                    jumped = true
                }
                if(endHours.count > 0 && jumped){
                    break
                }
            }
        }
        self.presenter?.availableTimes(hours: endHours)
    }
    
    func uploadTermin(day: Day, startIndex: Int, endIndex: Int, description:String) {
        let dayInMonth = Calendar.current.component(.day, from: day.date)
        let month = Calendar.current.component(.month, from: day.date)
        let year = Calendar.current.component(.year, from: day.date)
        let childDromDate = dayInMonth.description + "|" + month.description + "|" + year.description
        self.ref = Database.database().reference()
        var count = endIndex - startIndex
        for index in startIndex...endIndex - 1 {
            self.ref.child("termins").child(childDromDate).child(index.description).setValue(["username": MeetingUserDefaults.sharedInstance.getUsername(), "description": description], withCompletionBlock: { (error, ref) in
                count = count - 1
                if(count == 0){
                    self.presenter?.terminUpload(success: true)
                }
            })
        }
    }
    
    
}

