//
//  Helper+FirstLunch.swift
//  Guest-iOS
//
//  Created by Bassem on 12/19/17.
//  Copyright © 2017 Ibtikar. All rights reserved.
//

import Foundation


extension Helper {
    
    final class FirstLaunch {
        
        let wasLaunchedBefore: Bool
        var isFirstLaunch: Bool {
            return !wasLaunchedBefore
        }
        
        init(getWasLaunchedBefore: () -> Bool,
             setWasLaunchedBefore: (Bool) -> ()) {
            let wasLaunchedBefore = getWasLaunchedBefore()
            self.wasLaunchedBefore = wasLaunchedBefore
            if !wasLaunchedBefore {
                setWasLaunchedBefore(true)
            }
        }
        
        convenience init(userDefaults: UserDefaults, key: String) {
            self.init(getWasLaunchedBefore: { userDefaults.bool(forKey: key) },
                      setWasLaunchedBefore: { userDefaults.set($0, forKey: key) })
        }
        
    }
}
