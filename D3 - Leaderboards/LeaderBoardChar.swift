//
//  LeaderBoardChar.swift
//  D3 - Leaderboards
//
//  Created by Gustav Wadström on 2017-02-03.
//  Copyright © 2017 Gustav Wadström. All rights reserved.
//

import Foundation

class LeaderBoardChar {
    
    var heroClass: String
    var heroGender: String
    
    var rank: Int
    var riftLvl: Int
    var battleTag: String
    
    var time: TimeInterval
    
    required init(heroClass: String, gender: String, rank: Int, riftLvl: Int, battleTag: String, timestamp: Int) {
        
        self.heroClass = heroClass
        self.heroGender = gender
        self.rank = rank
        self.riftLvl = riftLvl
        self.battleTag = battleTag
        
        let time = TimeInterval(timestamp)
        self.time = time
        
    }
    
    
}
