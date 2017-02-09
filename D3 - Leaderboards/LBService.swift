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
    
    
    var characters = [LeaderBoardChar]()
    var seasons = [String]()
    
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
    
    
    func fetchList(completed: @escaping () -> (), hardCore: Bool, classString: String, season: String) {
        characters = []
        
        let URL: String
        
        let const = Constants.shared
        
        if hardCore {
            URL = const.Base_URL + season + const.Hardcore_URL + classString + const.access_token
            
        } else {
            URL = const.Base_URL + season + const.Softcore_URL + classString + const.access_token
        }
        
        print(URL)
        
        Alamofire.request(URL).responseJSON { response in
            
            
            let result = response.result
            
            if let dict = result.value as? Dictionary<String, AnyObject> {
                
                if let row = dict["row"] as? [Dictionary<String, AnyObject>] {
                    
                    var x = 1
                    
                    for index in row { //Index of type Dict
                        
                        var HeroClass: String = "none"
                        var HeroGender: String = "none"
                        
                        var Rank: Int = 0
                        var RiftLvl: Int = 0
                        var BattleTag: String = "None"
                        
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
                            
                            
                        }
                        
                        
                        let tableChar = LeaderBoardChar(heroClass: HeroClass, gender: HeroGender, rank: Rank, riftLvl: RiftLvl, battleTag: BattleTag)
                        self.characters.append(tableChar)
                        
                        
                        if x >= 500 {
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
    
    
    
}
