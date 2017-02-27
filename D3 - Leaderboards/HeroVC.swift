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
    
    @IBOutlet weak var hardcoreLbl: UILabel!
    @IBOutlet weak var seasonalLbl: UILabel!
    
    @IBOutlet weak var riftLvl: UILabel!
    @IBOutlet weak var riftTime: UILabel!
    
    @IBOutlet weak var isDeadLbl: UILabel!
    
    var char: Char!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateUI()
        
    }
    
    func updateUI() {
        
        
        
        
    }

    @IBAction func backPressed(_ sender: UIButton) {
        
        dismiss(animated: false, completion: nil)
        
    }
    
    
    
}
