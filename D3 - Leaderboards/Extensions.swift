//
//  Extensions.swift
//  D3 - Leaderboards
//
//  Created by Gustav Wadström on 2017-05-16.
//  Copyright © 2017 Gustav Wadström. All rights reserved.
//

import Foundation

extension TimeInterval {
    
    func toString() -> String {
        
        let interval = Int(self)
        let seconds = interval % 60
        let minutes = (interval / 60) % 60
        
        return String(format: "%02d:%02d", minutes, seconds)
    }
    
    
}
