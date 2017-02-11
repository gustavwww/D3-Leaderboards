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
    //Class Requires a HUGE code cleanup
    
    var characters = [LeaderBoardChar]()
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
                        
                        var Rank: Int = 0
                        var RiftLvl: Int = 0
                        var RiftTime: Int = 0
                        
                        if let player = index["player"] as? [Dictionary<String, AnyObject>] {
                            
                            if let data = player[0]["data"] as? [Dictionary<String, AnyObject>] {
                                //Character details.
                                
                                if let battleTag = data[0]["string"] as? String {
                                    
                                    BattleTag = battleTag
                                    
                                    
                                }
                                
                                if let heroClass = data[2]["string"] as? String {
                                    
                                    HeroClass = heroClass
                                    
                                }
                                
                                if let heroGenger = data[3]["string"] as? String {
                                    
                                    HeroGender = heroGenger
                                    
                                }
                                
                            }
                            
                            
                        }
                        
                        if let data = index["data"] as? [Dictionary<String, AnyObject>] {
                            //Data x Found
                            
                            //Rank, Rift level, BattleTag
                            //Placement details
                            
                            if let rank = data[0]["number"] as? Int {
                                
                                Rank = rank
                                
                            }
                            
                            if let riftLvl = data[1]["number"] as? Int {
                                
                                RiftLvl = riftLvl
                                
                            }
                            
                            if let riftTime = data[2]["timestamp"] as? Int {
                                
                                RiftTime = riftTime
                                
                            }
                            
                            
                        }
                        
                        
                        let tableChar = LeaderBoardChar(heroClass: HeroClass, gender: HeroGender, rank: Rank, riftLvl: RiftLvl, battleTag: BattleTag, timestamp: RiftTime)
                        self.characters.append(tableChar)
                        
                        
                        if x >= self.sizePerRegion {
                            completed()
                            return;
                        }
                        
                        x += 1
                    }
                    
                    
                }
                
            } else {
                //Error Downloading Data
                
                
            }
            
        }
        
        
    }
    
    func sortList() {
        
        let sorted = characters.sorted { (c1, c2) -> Bool in
            
            if c1.riftLvl != c2.riftLvl {
                
                return c1.riftLvl > c2.riftLvl
            }
            if c1.time != c2.time {
                
                return c1.time < c2.time
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
