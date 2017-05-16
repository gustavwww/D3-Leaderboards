//
//  Constants.swift
//  D3 - Leaderboards
//
//  Created by Gustav Wadström on 2017-02-02.
//  Copyright © 2017 Gustav Wadström. All rights reserved.
//

import Foundation

class Constants {
    
    static let shared = Constants()
    
    let START_URL = "https://" //Region
    
    let Base_URL = ".api.battle.net/data/d3/season/" //Season / rift-URL / Class / Access_Token
    let Hardcore_URL = "/leaderboard/rift-hardcore-"
    let Softcore_URL = "/leaderboard/rift-"
    
    var access_token = "?access_token=jasdfuhs78b863cb"
    
    //API class identifier
    let barb = "barbarian"
    let crusader = "crusader"
    let dh = "dh"
    let monk = "monk"
    let witchDoctor = "wd"
    let wizard = "wizard"
    
    
    var seasonURL = "https://eu.api.battle.net/data/d3/season/"
    
    
}
