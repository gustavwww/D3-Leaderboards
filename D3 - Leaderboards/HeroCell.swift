//
//  HeroCell.swift
//  D3 - Leaderboards
//
//  Created by Gustav Wadström on 2017-02-02.
//  Copyright © 2017 Gustav Wadström. All rights reserved.
//

import UIKit

class HeroCell: UITableViewCell {

    
    @IBOutlet weak var charImageView: UIImageView!
    @IBOutlet weak var battleTag: UILabel!
    @IBOutlet weak var griftLbl: UILabel!
    @IBOutlet weak var numberLbl: UILabel!

    func configureCell(tableChar: LeaderBoardChar) {
        
        battleTag.text = tableChar.battleTag
        griftLbl.text = "Grift: \(tableChar.riftLvl)"
        numberLbl.text = "\(tableChar.rank)"
        
        let imageStr = tableChar.heroClass + tableChar.heroGender
        charImageView.image = UIImage(named: imageStr)
        
        
    }
    
}
