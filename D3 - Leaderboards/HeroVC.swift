//
//  HeroVC.swift
//  D3 - Leaderboards
//
//  Created by Gustav Wadström on 2017-02-09.
//  Copyright © 2017 Gustav Wadström. All rights reserved.
//

import UIKit

class HeroVC: UIViewController {

    @IBOutlet weak var battleTag: UILabel!
    
    @IBOutlet weak var invImg: UIImageView!
    @IBOutlet weak var charImg: UIImageView!
    
    @IBOutlet weak var charName: UILabel!
    @IBOutlet weak var charLvl: UILabel!
    @IBOutlet weak var charParLvl: UILabel!
    
    @IBOutlet weak var hardcoreLbl: UILabel!
    @IBOutlet weak var seasonalLbl: UILabel!
    
    @IBOutlet weak var riftLvl: UILabel!
    @IBOutlet weak var riftTime: UILabel!
    
    @IBOutlet weak var isDeadLbl: UILabel!
    
    var char: Char!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        char.downloadDetails(completed: { //Can't load Hardcore Heroes?
            
            print("Char details successfully downloaded")
            self.updateUI()
            
        }, failed: {
            
            print("Char details failed to downlaod")
            
        })
        
    }
    
    func updateUI() {
        
        battleTag.text = char.battleTag
        riftLvl.text = "\(char.riftLvl)"
        riftTime.text = char.riftTime.toString()
        
        charImg.image = UIImage(named: char.heroClass + char.heroGender)
        invImg.image = UIImage(named: char.heroClass + char.heroGender + "-inv")
        
        charName.text = char.charName
        charLvl.text = "\(char.charLvl)"
        charParLvl.text = "\(char.charParLvl)"
        
        if char.isDead {
            isDeadLbl.isEnabled = true
        }
        
        if char.isHardCore {
            hardcoreLbl.text = "Yes"
        }
        
        if char.isSeasonal {
            seasonalLbl.text = "Yes"
        }
        
        
    }
    
    
    
    @IBAction func backPressed(_ sender: UIButton) {
        
        print("Executed")
        
    }
    
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        
    }
    
    
}
