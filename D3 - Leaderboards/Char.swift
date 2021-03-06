//
//  LeaderBoardChar.swift
//  D3 - Leaderboards
//
//  Created by Gustav Wadström on 2017-02-03.
//  Copyright © 2017 Gustav Wadström. All rights reserved.
//

import Foundation
import Alamofire

class Char {
    
    var heroClass: String
    var heroGender: String
    
    var rank: Int
    var riftLvl: Int
    var riftTime: TimeInterval
    
    var battleTag: String
    var heroId: Int
    var heroRegion: String
    
    var isHardCore: Bool
    
    
    var items = [Item]()
    
    
    //Downloadable Properties
    var isDead: Bool = false
    var isSeasonal: Bool = false
    
    private var _charName: String!
    private var _charLvl: Int!
    private var _charParLvl: Int!
    
    var charName: String {
        if _charLvl == nil {
            
            _charName = "Unknown"
        }
        
        return _charName
    }
    
    var charLvl: Int {
        if _charLvl == nil {
            
            _charLvl = 0
        }
        
        return _charLvl
    }
    
    var charParLvl: Int {
        
        if _charParLvl == nil {
            _charParLvl = 0
        }
        
        return _charParLvl
    }
    
    required init(heroClass: String, gender: String, rank: Int, riftLvl: Int, battleTag: String, heroId: Int, timestamp: Int, heroRegion: String, hardCore: Bool) {
        
        self.heroClass = heroClass
        self.heroGender = gender
        self.rank = rank
        self.riftLvl = riftLvl
        self.battleTag = battleTag
        self.heroId = heroId
        self.heroRegion = heroRegion
        self.isHardCore = hardCore
        
        let time = TimeInterval(timestamp)
        self.riftTime = time
        
    }
    
    
    func downloadDetails(completed: @escaping () -> (), failed: @escaping () -> ()) {
        //Item Details, CharName, CharLvl, etc
        
        let const = Constants.shared
        let URL_battleTag = self.battleTag.replacingOccurrences(of: "#", with: "%23")
        
        let URL = const.START_URL + self.heroRegion + const.Char_Base_URL + URL_battleTag + const.Hero_URL + "\(self.heroId)" + const.Locale_URL + const.API_KEY
        
        Alamofire.request(URL).responseJSON { response in
            
            let result = response.result
            
            if result.error != nil {
                //Error Downloading data
                print("Error: " + result.error.debugDescription)
                failed()
            }
            
            if let dict = result.value as? Dictionary<String, AnyObject> {
                print("Dict Found")
                print(self.battleTag)
                print(self.heroId)
                //Main Details
                if let name = dict["name"] as? String {
                    
                    self._charName = name
                    
                } else {
                    //Error Downloading data - Character could not be found, might be deleted.
                    print(self.battleTag)
                    print(self.heroId)
                    failed()
                }
                
                if let lvl = dict["level"] as? Int {
                    
                    self._charLvl = lvl
                    
                }
                
                if let parLvl = dict["paragonLevel"] as? Int { //Can't be found
                    print("GUSTAV: Found paragonLevel")
                    self._charParLvl = parLvl
                    
                }
                
                if let dead = dict["dead"] as? Bool {
                    
                    self.isDead = dead
                    
                }
                
                if let seasonal = dict["seasonal"] as? Bool {
                    
                    self.isSeasonal = seasonal
                    
                }
                
                //Item Fetching
                
                if let items = dict["items"] as? Dictionary<String, Dictionary<String, AnyObject>> { //Something wrong here... Not working for some characters.
                    print("Items dict found")
                    var itemsCounted = 1
                    
                    //Looping Items
                    for item in items {
                        print(item.key)
                        let itemType = item.key
                        var name = ""
                        var color = ""
                        var itemId = ""
                        var icon = ""
                        
                        
                        for x in item.value {
                            
                            switch x.key {
                                
                            case "name":
                                name = x.value as! String
                                break;
                                
                            case "id":
                                itemId = x.value as! String
                                break;
                                
                            case "displayColor":
                                color = x.value as! String
                                break;
                                
                            case "icon":
                                icon = x.value as! String
                                print(x.key)
                                break;
                                
                            default:
                                //Do a second try? - Default Values?
                                print("ITEM FETCHING: couldn't find icon, displaycolor, name etc.")
                                print(x.key)
                                break;
                                
                            }
                            
                        }
                        
                        let item = Item(itemType: itemType, name: name, color: color, itemId: itemId, icon: icon)
                        self.items.append(item)
                        
                        if itemsCounted == items.count {
                            
                            completed()
                            return
                        }
                        itemsCounted += 1
                        print(itemsCounted)
                    }
                    
                }
                
            }
            
        }
        
    }
    
}















