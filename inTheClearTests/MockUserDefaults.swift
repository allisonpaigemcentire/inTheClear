//
//  MockUserDefaults.swift
//  inTheClearTests
//
//  Created by Allison Mcentire on 5/8/22.
//

import Foundation

class MockUserDefaults : UserDefaults {
  
    convenience init() {
        self.init(suiteName: "Mock User Defaults")!
    }

    override init?(suiteName suitename: String?) {
        UserDefaults().removePersistentDomain(forName: suitename!)
        super.init(suiteName: suitename)
        self.set([28, 30, 31, 27, 32], forKey: "lengthOfEachCycle")
        let fourteenDaysBeforeToday = Calendar.current.date(byAdding: .day, value: -14, to: Date())!
        self.set(fourteenDaysBeforeToday, forKey: "lastPeriodEndDate")
    }
  
}
