//
//  CalculationManager.swift
//  inTheClear
//
//  Created by Allison Mcentire on 5/8/22.
//

import Foundation

class CalculationManager {
    
    let defaults = UserDefaults.standard
    
    func clearUserDefaults() {
        defaults.removeObject(forKey: "currentPeriodStartDate")
        defaults.object(forKey: "lengthOfEachCycle")
        defaults.object(forKey: "lastPeriodEndDate")
    }
    
    func recordCurrentPeriodStartDate() {
        defaults.set(Date(), forKey: "currentPeriodStartDate")
    }
    
    func recordLastPeriodEndDate() {
        defaults.set(Date(), forKey: "lastPeriodEndDate")
    }
    
    func recordCurrentPeriodEndDate() {
        defaults.removeObject(forKey: "currentPeriodStartDate")
        let numberOfDaysInLastCycle = numberOfDaysInLastCycle()
        guard var arrayOfLengthOfEachCycle = getArrayOfLengthOfEachCycle() else {
            defaults.set([numberOfDaysInLastCycle], forKey: "lengthOfEachCycle")
            return
        }
        arrayOfLengthOfEachCycle.append(numberOfDaysInLastCycle)
        defaults.set(arrayOfLengthOfEachCycle, forKey: "lengthOfEachCycle")
    }
    
    func getCurrentPeriodStartDate() -> Date? {
        // if value is nil, user is not currently recording a period
        return defaults.object(forKey: "currentPeriodStartDate") as? Date
    }
    
    func getLastPeriodEndDate() -> Date? {
        return defaults.object(forKey: "lastPeriodEndDate") as? Date
    }

    func getArrayOfLengthOfEachCycle() -> [Int]? {
        return defaults.object(forKey: "lengthOfEachCycle") as? Array
    }
    
    func numberOfDaysInCurrentPeriod() -> Int {
        guard let datePeriodBegan = getCurrentPeriodStartDate() else {
            return 0
        }
        
        let interval = Date() - datePeriodBegan
        // add 1 to returned value to display 1 for the first day, 2 for the second day etc
        return (interval.day ?? 0) + 1
    }
    
    func numberOfDaysUntilNextPeriod() -> Int {
        
        
        return 28
    }
    
    func averageDaysInCycle() -> Int {
        
        return 28
    }
    
    func numberOfDaysInLastCycle() -> Int {
        guard let dateLastPeriodEnded = getLastPeriodEndDate(), let currentPeriodStartDate = getCurrentPeriodStartDate() else {
            return 28
        }
        
        let interval = currentPeriodStartDate - dateLastPeriodEnded
        return interval.day ?? 0
    }
    
}
