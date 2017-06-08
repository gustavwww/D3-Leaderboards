//
//  Item.swift
//  D3 - Leaderboards
//
//  Created by Gustav Wadström on 2017-06-03.
//  Copyright © 2017 Gustav Wadström. All rights reserved.
//

import Foundation

class Item {
    
    var itemType: String
    
    var name: String
    var color: String
    var itemId: String
    
    required init(itemType: String, name: String, color: String, itemId: String) {
        
        self.itemType = itemType
        
        self.name = name
        self.color = color
        self.itemId = itemId
        
    }
    
    
}
