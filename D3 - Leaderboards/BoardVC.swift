//
//  ViewController.swift
//  D3 - Leaderboards
//
//  Created by Gustav Wadström on 2017-02-02.
//  Copyright © 2017 Gustav Wadström. All rights reserved.
//

import UIKit
import Alamofire
import GoogleMobileAds

class BoardVC: UIViewController, UITableViewDelegate, UITableViewDataSource, UIPickerViewDelegate, UIPickerViewDataSource {
    
    
    @IBOutlet weak var bannerView: GADBannerView!
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var segment: UISegmentedControl!
    
    @IBOutlet weak var seasonBtn: UIButton!
    @IBOutlet weak var classBtn: UIButton!
    @IBOutlet weak var regionBtn: UIButton!
    
    var lbService = LBService()
    
    var classArray = ["Barbarian", "Crusader", "Demon Hunter", "Monk", "Witch Doctor", "Wizard"]
    var regionArray = ["EU", "W"]
    
    var pickerInClassMode: Bool = true
    var pickerInRegionMode: Bool = false
    
    var currenClass = Constants.shared.barb
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupBanner()
        
        pickerView.delegate = self
        pickerView.dataSource = self
        
        tableView.delegate = self
        tableView.dataSource = self
        
        toggleInteract(enabled: false)
        lbService.downloadSeasons()
        reloadTable()
        
    }

    
    func setupBanner() {
        
        bannerView.adUnitID = "ca-app-pub-3940256099942544/2934735716" //"ca-app-pub-3305261733368372/7332501643"
        bannerView.rootViewController = self
        bannerView.load(GADRequest())
        
    }
    
    func reloadTable() {
        lbService.characters = []
        tableView.reloadData()
        
        if regionBtn.currentTitle == "EU" {
            
            lbService.fetchList(completed: {
            
            self.tableView.reloadData()
            self.toggleInteract(enabled: true)
                
        }, hardCore: getCoreState(), classString: currenClass, season: seasonBtn.currentTitle!, region: "eu")
            
            
        } else {
            
            lbService.fetchWorldList(completed: {
            
            self.tableView.reloadData()
            self.toggleInteract(enabled: true)
                
        }, hardCore: getCoreState(), classString: currenClass, season: seasonBtn.currentTitle!)
            
            
        }
        
    }
    
    func toggleInteract(enabled: Bool) {
        
        if enabled {
            //Board has stopped Loading
            seasonBtn.isEnabled = true
            classBtn.isEnabled = true
            regionBtn.isEnabled = true
            segment.isEnabled = true
            
            tableView.isScrollEnabled = true
            
            
        } else {
            //Board is Loading
            seasonBtn.isEnabled = false
            classBtn.isEnabled = false
            regionBtn.isEnabled = false
            segment.isEnabled = false
            
            tableView.scrollsToTop = true
            tableView.isScrollEnabled = false
            
            
        }
    }
    
    
    //Table View
    func numberOfSections(in tableView: UITableView) -> Int {
        
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        
        return lbService.characters.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "HeroCell", for: indexPath) as? HeroCell {
            
            let LBChar = lbService.characters[indexPath.row]
            LBChar.rank = indexPath.row + 1
            
            cell.configureCell(tableChar: LBChar)
            
            return cell
        }
        return HeroCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let char = lbService.characters[indexPath.row]
        
        performSegue(withIdentifier: "toHeroVC", sender: char)
        
    }
    
    
    //Segment
    @IBAction func segmentChanged(_ sender: UISegmentedControl) {
        toggleInteract(enabled: false)
        reloadTable()
        
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
        
        if pickerInRegionMode {
            
            return regionArray.count
        }
        
        if pickerInClassMode {
            
            return classArray.count
        }
        
        return lbService.seasons.count
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        if pickerInRegionMode {
            
            return regionArray[row]
        }
        
        if pickerInClassMode {
            
            return classArray[row]
        }
        
        return lbService.seasons[row]
    }
    
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        if pickerInRegionMode {
            //Region Selection
            
            regionBtn.setTitle(regionArray[row], for: .normal)
            pickerView.isHidden = true
            toggleInteract(enabled: false)
            reloadTable()
            
            resetPickerMode()
            return
        }
        
        if pickerInClassMode {
            //Class Selector
            
            classBtn.setTitle(classArray[row], for: .normal)
            
            var classStr = ""
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
            toggleInteract(enabled: false)
            reloadTable()
        
            resetPickerMode()
            return
        }
        //Season Selection
        if !lbService.seasons.isEmpty {
            
           seasonBtn.setTitle(lbService.seasons[row], for: .normal)
            
        } else {
            seasonBtn.setTitle("9", for: .normal)
        }
        
        
            pickerView.isHidden = true
            toggleInteract(enabled: false)
            reloadTable()
        
    }
    
    @IBAction func seasonBtnPressed(_ sender: UIButton) {
        resetPickerMode()
        
        
        if !pickerView.isHidden {
            pickerView.isHidden = true
            return
        }
        
        self.pickerView.isHidden = false
        self.pickerView.reloadAllComponents()
        
    }
    
    @IBAction func classBtnPressed(_ sender: UIButton) {
        resetPickerMode()
        
        if !pickerView.isHidden {
            pickerView.isHidden = true
            return
        }
        
        pickerInClassMode = true
        pickerView.isHidden = false
        pickerView.reloadAllComponents()
        
    }
    
    @IBAction func regionBtnPressed(_ sender: UIButton) {
        resetPickerMode()
        
        if !pickerView.isHidden {
            pickerView.isHidden = true
            
            return
        }
        
        pickerInRegionMode = true
        pickerView.isHidden = false
        pickerView.reloadAllComponents()
        
    }
    
    func resetPickerMode() {
        
        pickerInRegionMode = false
        pickerInClassMode = false
        
    }
    
    
    //Segue
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let destination = segue.destination as? MenuVC {
            
            destination.fromVC = self
            
        }
        
        if let destination = segue.destination as? HeroVC {
            //Send Character (Sender)
            
            if let char = sender as? Char {
                
                destination.char = char
            }
            
        }
        
        
    }
    

}

