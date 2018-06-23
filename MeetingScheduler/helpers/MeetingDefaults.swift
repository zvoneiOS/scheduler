//
//  MeetingDefaults.swift
//  MeetingScheduler
//

import Foundation

struct Keys {
    static let username = "username"
}

class MeetingUserDefaults {
    
    static let sharedInstance = MeetingUserDefaults()
    
    func setUsername(username:String) {
        UserDefaults.standard.set(username, forKey: Keys.username)
    }
    
    func getUsername() -> String {
        return  UserDefaults.standard.string(forKey: Keys.username)!
    }
    
}
