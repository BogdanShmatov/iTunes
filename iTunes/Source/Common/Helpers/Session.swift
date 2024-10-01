//
//  Session.swift
//  iTunes
//
//  Created by Bogdan Shmatov on 01.10.2024.
//

import Foundation

struct Session {
    
    //Flag is used for define is open seen onboarding or not
    
    static var isSeenOnboarding: Bool {
        get {
            return UserDefaults.standard.bool(forKey: "isSeenOnboarding")
        }
        set {
            UserDefaults.standard.setValue(newValue, forKey: "isSeenOnboarding")
        }
    }
}
