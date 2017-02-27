//
//  LeaderBoardChar.swift
//  D3 - Leaderboards
//
//  Created by Gustav Wadström on 2017-02-03.
//  Copyright © 2017 Gustav Wadström. All rights reserved.
//

import Foundation

class Char {
    
    var heroClass: String
    var heroGender: String
    
    var rank: Int
    var riftLvl: Int
    var riftTime: TimeInterval
    
    var battleTag: String
    var heroId: Int
    var heroRegion: String
    

    
    //Downloadable Properties
    var isDead: Bool = false
    var isSeasonal: Bool = false
    
    private var _charName: String!
    private var _charLvl: Int!
    
    var charName: String {
        if _charLvl == nil {
            
            _charName = ""
        }
        
        return _charName
    }
    
    var charLvl: Int {
        if _charLvl == nil {
            
            _charLvl = 0
        }
        
        return _charLvl
    }
    
    required init(heroClass: String, gender: String, rank: Int, riftLvl: Int, battleTag: String, heroId: Int, timestamp: Int, heroRegion: String) {
        
        self.heroClass = heroClass
        self.heroGender = gender
        self.rank = rank
        self.riftLvl = riftLvl
        self.battleTag = battleTag
        self.heroId = heroId
        self.heroRegion = heroRegion
        
        let time = TimeInterval(timestamp)
        self.riftTime = time
        
    }
    
    
    func downloadDetails(Completed: @escaping () -> ()) {
        //Item Details, CharName, CharLvl
        
        
        
    }
    
    
}












