//
//  ConversionUtils.swift
//  MeetingScheduler
//

import Foundation

class ConversionUtils {

    static func convertIndexToTime(index:Int) -> String{
        var time = ""
        let startTimeInt = 8 + index/2
        if(startTimeInt < 10){
            time = "0" + startTimeInt.description
        }else{
            time = startTimeInt.description
        }
        if(index % 2 == 1){
            time = time + ":30"
        }else{
            time = time + ":00"
        }
        return time
    }
    
    static func convertTimeToIndex(time:String) -> Int{
        var index = 0
        let timeArray = time.split(separator: ":")
        let hour = Int(timeArray[0])!
        index = (hour - 8) * 2
        if(timeArray[1] == "30"){
            index = index + 1
        }
        return index
    }
}
