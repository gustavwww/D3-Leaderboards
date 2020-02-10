//
//  Item.swift
//  D3 - Leaderboards
//
//  Created by Gustav Wadström on 2017-06-03.
//  Copyright © 2017 Gustav Wadström. All rights reserved.
//

import Foundation
import UIKit

class Item {
    
    var itemType: String
    
    var name: String
    var color: String
    var itemId: String
    var icon: String
    
    private var _itemImg: UIImage!
    
    var itemImg: UIImage {
        
        if _itemImg == nil {
            return UIImage()
        }
        
        return _itemImg
    }
    
    required init(itemType: String, name: String, color: String, itemId: String, icon: String) {
        
        self.itemType = itemType
        
        self.name = name
        self.color = color
        self.itemId = itemId
        self.icon = icon
    }
    
    
    func downloadIcon(completed: @escaping () -> (), failed: @escaping () -> ()) {
        
        let url = URL(string: "http://media.blizzard.com/d3/icons/items/large/\(self.icon).png")!
        
        let session = URLSession(configuration: .default)
        
        let getImageFromUrl = session.dataTask(with: url) { (data, response, error) in
            
            if error != nil {
                failed()
                
                return
            }
            
            if (response as? HTTPURLResponse) != nil {
                
                if let imageData = data {
                    
                    let image = UIImage(data: imageData)
                    
                    self._itemImg = image
                    
                    completed()
                } else {failed()}
                
            } else {failed()}
            
        }
        
        getImageFromUrl.resume()
        
    }
    
    
}
