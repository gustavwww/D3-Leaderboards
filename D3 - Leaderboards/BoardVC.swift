//
//  ViewController.swift
//  D3 - Leaderboards
//
//  Created by Gustav Wadström on 2017-02-02.
//  Copyright © 2017 Gustav Wadström. All rights reserved.
//

import UIKit
import Alamofire

class BoardVC: UIViewController, UITableViewDelegate, UITableViewDataSource, UIPickerViewDelegate, UIPickerViewDataSource {

    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var segment: UISegmentedControl!
    
    @IBOutlet weak var seasonBtn: UIButton!
    @IBOutlet weak var classBtn: UIButton!
    
    
    var pickerArray = [String]()
    var classArray = ["Barbarian", "Crusader", "Demon Hunter", "Monk", "Witch Doctor", "Wizard"]
    var inClassMode: Bool = true
    
    var currenClass = Constants.shared.barb
    
    var tableCharachters = [LeaderBoardChar]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pickerView.delegate = self
        pickerView.dataSource = self
        
        tableView.delegate = self
        tableView.dataSource = self
        
        fetchList(completed: { 
            print("Download complete")
            
            self.tableView.reloadData()
            
        }, hardCore: false, classString: currenClass, season: seasonBtn.currentTitle!)
        
    }
    
    //Fetch Function
    func fetchList(completed: @escaping () -> (), hardCore: Bool, classString: String, season: String) {
        tableCharachters = []
        tableView.reloadData()
        
        
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
                        var HeroClass: String = "none"
                        var HeroGender: String = "none"
                        
                        var Rank: Int = 0
                        var RiftLvl: Int = 0
                        var BattleTag: String = "None"
                        
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
    
    //Table View
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
    
    
    //Segment
    @IBAction func segmentChanged(_ sender: UISegmentedControl) {
        
        switch segment.selectedSegmentIndex {
        case 0:
            //Softcore
            
            fetchList(completed: { 
                
                self.tableView.reloadData()
                
            }, hardCore: false, classString: currenClass, season: seasonBtn.currentTitle!)
            
        case 1:
            //Hardcore
            
            fetchList(completed: { 
                
                self.tableView.reloadData()
                
            }, hardCore: true, classString: currenClass, season: seasonBtn.currentTitle!)
            
        default:
            
            break;
        }
        
        
    }
    
    func getCoreState() -> Bool {
        
        var isHardCore = false
        
        if segment.selectedSegmentIndex == 1 {
            isHardCore = true
        }
        
        return isHardCore
    }
    
    //Picker View
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        if inClassMode {
            print("Returning ClassMode Count")
            return classArray.count
        }
        print("Returning pickerArray Count")
        return pickerArray.count
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        if inClassMode {
            print("Returning ClassMode Row")
            return classArray[row]
        }
        print("Returning pickerArray Row")
        return pickerArray[row]
    }
    
    
    @IBAction func seasonBtnPressed(_ sender: UIButton) {
        //Download Seasons
        pickerArray = []
        pickerView.reloadAllComponents()
        
        let URL = Constants.shared.seasonURL
        
        Alamofire.request(URL).responseJSON { (response) in
            
            let result = response.result
            
            if let dict = result.value as? Dictionary<String, AnyObject> {
                
                if let seasons = dict["season"] as? [Dictionary<String, AnyObject>] {
                    
                    for x in 1...seasons.count {
                        
                        self.pickerArray.append("\(x)")
                        
                        
                    }
                    
                    
                }
                
            }
            
            self.pickerView.isHidden = false
            self.inClassMode = false
            self.pickerView.reloadAllComponents()
        }
        
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        //Season Selection
        
        if !inClassMode {
            print("Did select row (NOT CLASS MODE)")
        seasonBtn.setTitle(pickerArray[row], for: .normal)
        pickerView.isHidden = true
        
        fetchList(completed: {
            
            self.tableView.reloadData()
            
        }, hardCore: getCoreState(), classString: currenClass, season: pickerArray[row])
        
        } else {
            //Class Selector
            classBtn.setTitle(classArray[row], for: .normal)
            var classStr = "dh"
            pickerView.isHidden = true
            
            switch classArray[row] {
            case "Barbarian":
                classStr = Constants.shared.barb
                
            case "Crusader":
                classStr = Constants.shared.crusader
                
            case "Demon Hunter":
                classStr = Constants.shared.dh
                
            case "Monk":
                classStr = Constants.shared.monk
                
            case "Witch Doctor":
                classStr = Constants.shared.witchDoctor
                
            case "Wizard":
                classStr = Constants.shared.wizard
                
            default:
                
                break;
            }
            
            currenClass = classStr
            
            fetchList(completed: { 
                
                self.tableView.reloadData()
                
            }, hardCore: getCoreState(), classString: classStr, season: self.seasonBtn.currentTitle!)
            
            
        }
        
        
    }
    
    @IBAction func classBtnPressed(_ sender: UIButton) {
        inClassMode = true
        pickerView.isHidden = false
        pickerView.reloadAllComponents()
        
    }
    

}

