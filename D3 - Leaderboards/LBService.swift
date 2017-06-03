//
//  LBService.swift
//  D3 - Leaderboards
//
//  Created by Gustav Wadström on 2017-02-09.
//  Copyright © 2017 Gustav Wadström. All rights reserved.
//

import Foundation
import Alamofire

class LBService {
    
    var characters = [Char]()
    var seasons = [String]()
    
    var sizePerRegion = 300
    
    func downloadSeasons() {
        //Download Seasons
        seasons = []
        
        let URL = Constants.shared.seasonURL
        
        Alamofire.request(URL).responseJSON { (response) in
            
            let result = response.result
            
            if let dict = result.value as? Dictionary<String, AnyObject> {
                
                if let seasons = dict["season"] as? [Dictionary<String, AnyObject>] {
                    
                    for x in 1...seasons.count {
                        
                        self.seasons.append("\(x)")
                        
                        
                    }
                    
                    
                }
                
            }
            
        }
        
    }
    
    
    func fetchList(completed: @escaping () -> (), hardCore: Bool, classString: String, season: String, region: String) {
        
        let URL: String
        
        let const = Constants.shared
        
        if hardCore {
            URL = const.START_URL + region + const.Base_URL + season + const.Hardcore_URL + classString + const.access_token
            
        } else {
            URL = const.START_URL + region + const.Base_URL + season + const.Softcore_URL + classString + const.access_token
        }
        
        print(URL)
        
        Alamofire.request(URL).responseJSON { response in
            
            
            let result = response.result
            
            if let dict = result.value as? Dictionary<String, AnyObject> {
                
                if let row = dict["row"] as? [Dictionary<String, AnyObject>] {
                    
                    var x = 1
                    
                    for index in row { //Index of type Dict
                        
                        var BattleTag: String = "None"
                        var HeroClass: String = "none"
                        var HeroGender: String = "none"
                        var HeroId: Int = 0
                        
                        var Rank: Int = 0
                        var RiftLvl: Int = 0
                        var RiftTime: Int = 0
                        
                        if let player = index["player"] as? [Dictionary<String, AnyObject>] {
                            
                            if let data = player[0]["data"] as? [Dictionary<String, AnyObject>] {
                                //Character details.
                                
                                for x in data {
                                    
                                    
                                    if x["id"] as? String == "HeroBattleTag" {
                                        
                                        if let battleTag = x["string"] as? String {
                                            
                                            BattleTag = battleTag
                                            
                                        }
                                        
                                    }
                                    
                                    if x["id"] as? String == "HeroClass" {
                                        
                                        if let heroClass = x["string"] as? String {
                                            
                                            HeroClass = heroClass
                                            
                                        }
                                        
                                    }
                                    
                                    if x["id"] as? String == "HeroGender" {
                                        
                                        if let heroGenger = x["string"] as? String {
                                            
                                            HeroGender = heroGenger
                                            
                                        }
                                        
                                    }
                                    
                                    if x["id"] as? String == "HeroId" {
                                        
                                        if let heroId = x["number"] as? Int {
                                            
                                            HeroId = heroId
                                            
                                        }
                                        
                                    }
                                    
                                }
                                
                                
                            }
                            
                            
                        }
                        
                        if let data = index["data"] as? [Dictionary<String, AnyObject>] {
                            //Data x Found
                            
                            //Rank, Rift-Level, Rift-Time
                            //Placement details
                            
                            for x in data {
                                
                                if x["id"] as? String == "Rank" {
                                    
                                    if let rank = x["number"] as? Int {
                                        
                                        Rank = rank
                                        
                                    }
                                    
                                }
                                
                                if x["id"] as? String == "RiftLevel" {
                                    
                                    if let riftLvl = x["number"] as? Int {
                                        
                                        RiftLvl = riftLvl
                                        
                                    }
                                    
                                }
                                
                                if x["id"] as? String == "RiftTime" {
                                    
                                    if let riftTime = x["timestamp"] as? Int {
                                        
                                        RiftTime = riftTime
                                        
                                    }
                                    
                                }
                                
                            }
                            
                            
                        }
                        
                        
                        let tableChar = Char(heroClass: HeroClass, gender: HeroGender, rank: Rank, riftLvl: RiftLvl, battleTag: BattleTag, heroId: HeroId, timestamp: RiftTime, heroRegion: region)
                        self.characters.append(tableChar)
                        
                        
                        if x >= self.sizePerRegion {
                            completed()
                            return;
                        }
                        
                        x += 1
                    }
                    
                    
                }
                
            } else {
                //Error Downloading Data - Handle
                
                
            }
            
        }
        
        
    }
    
    func sortList() {
        
        let sorted = characters.sorted { (c1, c2) -> Bool in
            
            if c1.riftLvl != c2.riftLvl {
                
                return c1.riftLvl > c2.riftLvl
            }
            if c1.riftTime != c2.riftTime {
                
                return c1.riftTime < c2.riftTime
            }
            
            return false
        }
        characters = sorted
        
    }
    
    func fetchWorldList(completed: @escaping () -> (), hardCore: Bool, classString: String, season: String) {
        
        var downloadsFinished = 0
        
        func checkDownloads() {
            
            if downloadsFinished == 3 {
                
                sortList()
                completed()
            }
        
        }
        
        fetchList(completed: { 
            downloadsFinished += 1
            checkDownloads()
        }, hardCore: hardCore, classString: classString, season: season, region: "eu")

        fetchList(completed: { 
            downloadsFinished += 1
            checkDownloads()
        }, hardCore: hardCore, classString: classString, season: season, region: "us")
        
        fetchList(completed: { 
            downloadsFinished += 1
            checkDownloads()
        }, hardCore: hardCore, classString: classString, season: season, region: "kr")
        
    }
    
    
    
}
