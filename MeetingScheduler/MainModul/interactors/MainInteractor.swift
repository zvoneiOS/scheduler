//
//  MainInteractor.swift
//  MeetingScheduler
//

import Foundation
import Firebase
import FirebaseDatabase
import FirebaseAuth

class MainInteractor: MainInteractorInputProtocol {
    
    weak var presenter: MainInteractorOutputProtocol?
    var ref: DatabaseReference!
    
    func logoutUser(){
        do{
            try Auth.auth().signOut()
            MeetingUserDefaults.sharedInstance.setUsername(username: "")
            self.presenter?.loggedOut()
        }catch{
            
        }
    }
    
    func fetchDaysAndFilterThem(days: [Day]) {
        var newDays = days
        self.ref = Database.database().reference()
        self.ref.child("termins").observe(.value) { (snapshot) in
            let value = snapshot.value as? NSDictionary
           
            for day in 0..<days.count {
                for hour in 0..<days[0].hours!.count {
                    newDays[day].hours![hour].taken=false
                    newDays[day].hours![hour].description=nil
                    newDays[day].hours![hour].username=nil
                }
            }
            
            for (index, day) in days.enumerated(){
                let dayInMonth = Calendar.current.component(.day, from: day.date)
                let month = Calendar.current.component(.month, from: day.date)
                let year = Calendar.current.component(.year, from: day.date)
                let childDromDate = dayInMonth.description + "|" + month.description + "|" + year.description
                if value != nil {
                    if let array = value![childDromDate] as? NSArray {
                        for (k,item) in array.enumerated(){
                            if let termin = item as? NSDictionary {
                                newDays[index].hours![k].taken = true
                                newDays[index].hours![k].username = termin["username"] as? String
                                newDays[index].hours![k].description = termin["description"] as? String
                            }
                        }
                    }else if let one = value![childDromDate] as? NSDictionary {
                        for key in one.allKeys{
                            newDays[index].hours![Int(key as! String)!].taken = true
                            let termin = one.value(forKey: key as! String) as! NSDictionary
                            newDays[index].hours![Int(key as! String)!].username = termin["username"] as? String
                            newDays[index].hours![Int(key as! String)!].description = termin["description"] as? String
                        }
                    }
                }
                
            }
            self.presenter?.daysFetched(days: newDays)
        }
    }
    
    func deleteTermin(hour: Hour, day: Day){
        let dayInMonth = Calendar.current.component(.day, from: day.date)
        let month = Calendar.current.component(.month, from: day.date)
        let year = Calendar.current.component(.year, from: day.date)
        let childDromDate = dayInMonth.description + "|" + month.description + "|" + year.description
        self.ref = Database.database().reference()
        self.ref.child("termins").child(childDromDate).child(String(hour.index)).removeValue(completionBlock: {
            (error, ref) in
            if error != nil {
                print(error)
            }
        })
    }
}
