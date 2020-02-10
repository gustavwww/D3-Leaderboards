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
        
        initItemSlots(contentMode: .scaleAspectFill)

        char.downloadDetails(completed: { //Can't load some Heroes?

            print("Char details successfully downloaded")
            self.updateUI()
            self.updateItems()
        }, failed: {

            print("Char details failed to downlaod")
            self.updateUI()
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
                    
                    switch item.itemType {
                        
                    case "head":
                        self.head.setImage(img, for: .normal)
                        self.head.setBackgroundColor(colorString: item.color)
                        break;
                        
                    case "neck":
                        self.neck.setImage(img, for: .normal)
                        self.neck.setBackgroundColor(colorString: item.color)
                        break;
                        
                    case "shoulders":
                        self.shoulders.setImage(img, for: .normal)
                        self.shoulders.setBackgroundColor(colorString: item.color)
                        break;
                        
                    case "torso":
                        self.torso.setImage(img, for: .normal)
                        self.torso.setBackgroundColor(colorString: item.color)
                        break;
                        
                    case "hands":
                        self.hands.setImage(img, for: .normal)
                        self.hands.setBackgroundColor(colorString: item.color)
                        break;
                        
                    case "bracers":
                        self.bracers.setImage(img, for: .normal)
                        self.bracers.setBackgroundColor(colorString: item.color)
                        break;
                        
                    case "waist":
                        self.waist.setImage(img, for: .normal)
                        self.waist.setBackgroundColor(colorString: item.color)
                        break;
                        
                    case "legs":
                        self.legs.setImage(img, for: .normal)
                        self.legs.setBackgroundColor(colorString: item.color)
                        break;
                        
                    case "feet":
                        self.feet.setImage(img, for: .normal)
                        self.feet.setBackgroundColor(colorString: item.color)
                        break;
                        
                    case "leftFinger":
                        self.leftFinger.setImage(img, for: .normal)
                        self.leftFinger.setBackgroundColor(colorString: item.color)
                        break;
                        
                    case "rightFinger":
                        self.rightFinger.setImage(img, for: .normal)
                        self.rightFinger.setBackgroundColor(colorString: item.color)
                        break;
                        
                    case "mainHand":
                        self.mainHand.setImage(img, for: .normal)
                        self.mainHand.setBackgroundColor(colorString: item.color)
                        break;
                        
                    case "offHand":
                        self.offHand.setImage(img, for: .normal)
                        self.offHand.setBackgroundColor(colorString: item.color)
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
    
    func initItemSlots(contentMode: UIViewContentMode) {
        
        
        head.imageView?.contentMode = contentMode
        neck.imageView?.contentMode = contentMode
        shoulders.imageView?.contentMode = contentMode
        torso.imageView?.contentMode = contentMode
        hands.imageView?.contentMode = contentMode
        bracers.imageView?.contentMode = contentMode
        waist.imageView?.contentMode = contentMode
        legs.imageView?.contentMode = contentMode
        feet.imageView?.contentMode = contentMode
        leftFinger.imageView?.contentMode = contentMode
        rightFinger.imageView?.contentMode = contentMode
        mainHand.imageView?.contentMode = contentMode
        offHand.imageView?.contentMode = contentMode
        
        
    }
    
    
    @IBAction func backPressed(_ sender: UIButton) {
        print("Pressed")
        dismiss(animated: true, completion: nil)
    }
    
    
    deinit {
        print(self, "Removed")
    }

    
    
    
}























