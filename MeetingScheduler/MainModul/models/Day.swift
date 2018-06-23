//
//  Day.swift
//  MeetingScheduler
//

import Foundation

struct Day {
    
    let date:Date
    var hours:[Hour]?
    
    init(date:Date) {
        self.date = date
        self.hours = [Hour]()
        for index in 0...19 {
            let hour = Hour.init(index: index)
            self.hours?.append(hour)
        }
    }
    
}

struct Hour {
    
    let index:Int
    var username:String?
    var description:String?
    var taken = false
    
    init(index:Int) {
        self.index = index
    }
    
}
