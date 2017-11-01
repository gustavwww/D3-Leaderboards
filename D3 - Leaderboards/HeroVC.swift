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

        char.downloadDetails(completed: { //Can't load some Heroes?

            print("Char details successfully downloaded")
            self.updateUI()
            self.updateItems()
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
    
    //Items
    
    @IBOutlet weak var head: UIButton!
    @IBOutlet weak var neck: UIButton!
    @IBOutlet weak var shoulders: UIButton!
    @IBOutlet weak var torso: UIButton! //Chest
    @IBOutlet weak var hands: UIButton!
    @IBOutlet weak var bracers: UIButton!
    @IBOutlet weak var waist: UIButton! //Belt
    @IBOutlet weak var legs: UIButton!
    @IBOutlet weak var feet: UIButton!
    @IBOutlet weak var leftFinger: UIButton!
    @IBOutlet weak var rightFinger: UIButton!
    @IBOutlet weak var mainHand: UIButton!
    @IBOutlet weak var offHand: UIButton!
    
    
    func updateItems() {
        print("Updating items..")
        for item in char.items {
            print(item.itemType + " - Before Download")
            item.downloadIcon(completed: {
                print("ITEM DOWNLOAD COMPLETED")
                print(item.itemType)
                
                let img = item.itemImg
                
                DispatchQueue.main.async {
                    
                    switch item.itemType { //Items getting blue - WORK ON THIS <<< BckgroundImg?
                        
                    case "head":
                        self.head.setImage(img, for: .normal)
                        break;
                        
                    case "neck":
                        self.neck.setImage(img, for: .normal)
                        break;
                        
                    case "shoulders":
                        self.shoulders.setImage(img, for: .normal)
                        break;
                        
                    case "torso":
                        self.torso.setImage(img, for: .normal)
                        break;
                        
                    case "hands":
                        self.hands.setImage(img, for: .normal)
                        break;
                        
                    case "bracers":
                        self.bracers.setImage(img, for: .normal)
                        break;
                        
                    case "waist":
                        self.waist.setImage(img, for: .normal)
                        break;
                        
                    case "legs":
                        self.legs.setImage(img, for: .normal)
                        break;
                        
                    case "feet":
                        self.feet.setImage(img, for: .normal)
                        break;
                        
                    case "leftFinger":
                        self.leftFinger.setImage(img, for: .normal)
                        break;
                        
                    case "rightFinger":
                        self.rightFinger.setImage(img, for: .normal)
                        break;
                        
                    case "mainHand":
                        self.mainHand.setImage(img, for: .normal)
                        break;
                        
                    case "offHand":
                        self.offHand.setImage(img, for: .normal)
                        break;
                        
                        
                    default:
                        //Do Nothing
                        break;
                        
                    }
                    
                }
                

                
                
            }, failed: {
                print("Item failed to download")
            })
            
        }
        
        
        
    }
    
    
    @IBAction func backPressed(_ sender: UIButton) {
        print("Pressed")
        navigationController?.popViewController(animated: true)
        
    }
    
    
    
}























