//
//  ViewController.swift
//  D3 - Leaderboards
//
//  Created by Gustav Wadström on 2017-02-02.
//  Copyright © 2017 Gustav Wadström. All rights reserved.
//

import UIKit
import Alamofire

class BoardVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var segment: UISegmentedControl!
    
    var tableCharachters = [LeaderBoardChar]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        fetchList(completed: { 
            print("Download complete")
            
            self.tableView.reloadData()
            
        }, hardCore: true, classString: Constants.shared.dh, season: "8")
        
    }
    
    func fetchList(completed: @escaping () -> (), hardCore: Bool, classString: String, season: String) {
        
        let URL: String
        
        let const = Constants.shared
        
        if hardCore {
            URL = const.Base_URL + season + const.Hardcore_URL + classString + const.access_token
            
        } else {
            URL = const.Base_URL + season + const.Softcore_URL + classString + const.access_token
        }
        
        print(URL)
        
        Alamofire.request(URL).responseJSON { response in
            print("Downloading...")
            
            let result = response.result
            
            if let dict = result.value as? Dictionary<String, AnyObject> {
                
                if let row = dict["row"] as? [Dictionary<String, AnyObject>] {
                    
                    var x = 1
                    
                    for index in row { //Index of type Dict
                        print("Looping Row")
                        var HeroClass: String = "demon hunter"
                        var HeroGender: String = "m"
                        
                        var Rank: Int = 1
                        var RiftLvl: Int = 1
                        var BattleTag: String = ""
                        
                        if let player = index["player"] as? [Dictionary<String, AnyObject>] {
                            
                            if let data = player[0]["data"] as? [Dictionary<String, AnyObject>] {
                                //Character details.
                                
                                if let heroClass = data[2]["string"] as? String {
                                    
                                    HeroClass = heroClass
                                    print("HeroClass Downloaded \(heroClass)")
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
                            
                            if let battleTag = data[4]["string"] as? String {
                                
                                BattleTag = battleTag
                                print("Battle tag downloaded")
                            }
                            
                            
                        }
                        print("Creating Char Object")
                        
                        let tableChar = LeaderBoardChar(heroClass: HeroClass, gender: HeroGender, rank: Rank, riftLvl: RiftLvl, battleTag: BattleTag)
                        self.tableCharachters.append(tableChar)
                        
                        
                        if x >= 100 {
                            completed()
                            return;
                        }
                        
                        x += 1
                    }
                    
                    
                }
                
            }
            
        }
        
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        
        return tableCharachters.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print("Cell for row at running...")
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "HeroCell", for: indexPath) as? HeroCell {
            print("Configuring cell..")
            cell.configureCell(tableChar: tableCharachters[indexPath.row])
            
            print(tableCharachters[indexPath.row].battleTag)
            
            return cell
        }
        return HeroCell()
    }

}

