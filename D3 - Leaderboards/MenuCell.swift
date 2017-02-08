//
//  MenuCell.swift
//  D3 - Leaderboards
//
//  Created by Gustav Wadström on 2017-02-08.
//  Copyright © 2017 Gustav Wadström. All rights reserved.
//

import UIKit

class MenuCell: UITableViewCell {

    @IBOutlet weak var nameLbl: UILabel!
    
    func configureCell(_ name: String) {
        
        nameLbl.text = name
        
    }

}
