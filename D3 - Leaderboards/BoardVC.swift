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
    
    var lbService = LBService()
    
    
    var classArray = ["Barbarian", "Crusader", "Demon Hunter", "Monk", "Witch Doctor", "Wizard"]
    
    var pickerInClassMode: Bool = true
    
    var currenClass = Constants.shared.barb

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pickerView.delegate = self
        pickerView.dataSource = self
        
        tableView.delegate = self
        tableView.dataSource = self
        
        lbService.downloadSeasons()
        reloadTable()
        
        
    }
    
    func reloadTable() {
        lbService.characters = []
        tableView.reloadData()
        
        lbService.fetchList(completed: {
            
            self.tableView.reloadData()
            
        }, hardCore: getCoreState(), classString: currenClass, season: seasonBtn.currentTitle!)
        
        
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
            
            cell.configureCell(tableChar: lbService.characters[indexPath.row])
            
            print(lbService.characters[indexPath.row].battleTag)
            
            return cell
        }
        return HeroCell()
    }
    
    
    //Segment
    @IBAction func segmentChanged(_ sender: UISegmentedControl) {
        
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
        
        if pickerInClassMode {
            
            return classArray.count
        }
        
        return lbService.seasons.count
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        if pickerInClassMode {
            
            return classArray[row]
        }
        
        return lbService.seasons[row]
    }
    
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        //Season Selection
        
        if !pickerInClassMode {
            
        
            seasonBtn.setTitle(lbService.seasons[row], for: .normal)
        
            pickerView.isHidden = true
            
            reloadTable()
        
        } else {
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
            
            reloadTable()
            
        }
        
        
    }
    
    @IBAction func seasonBtnPressed(_ sender: UIButton) {
        
        if !pickerView.isHidden {
            pickerView.isHidden = true
            return
        }
        
        self.pickerInClassMode = false
        self.pickerView.isHidden = false
        self.pickerView.reloadAllComponents()
        
    }
    
    @IBAction func classBtnPressed(_ sender: UIButton) {
        
        if !pickerView.isHidden {
            pickerView.isHidden = true
            return
        }
        
        pickerInClassMode = true
        pickerView.isHidden = false
        pickerView.reloadAllComponents()
        
    }
    
    
    
    
    //Segue
    @IBAction func menuBtnPressed(_ sender: UIButton) {
        
        performSegue(withIdentifier: "toMenu", sender: nil)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let destination = segue.destination as? MenuVC {
            
            destination.fromVC = self
            
        }
        
        
    }
    

}

