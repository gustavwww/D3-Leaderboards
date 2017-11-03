//
//  BackgroundColorExtension.swift
//  D3 - Leaderboards
//
//  Created by Gustav Wadström on 2017-11-03.
//  Copyright © 2017 Gustav Wadström. All rights reserved.
//

import Foundation
import UIKit

extension UIButton {
    
    
    func setBackgroundColor(colorString: String) {
        
        
        switch colorString {
            
        case "orange":
            self.backgroundColor = UIColor(red:0.67, green:0.43, blue:0.07, alpha:0.3)
            break;
            
        case "green":
            self.backgroundColor = UIColor(red:0.16, green:0.89, blue:0.11, alpha:0.1)
            break;
            
        case "yellow":
            self.backgroundColor = UIColor(red:0.96, green:0.95, blue:0.13, alpha:0.1)
            break;
            
        case "white":
            self.backgroundColor = UIColor(red:1.00, green:1.00, blue:1.00, alpha:0.2)
            break;
            
        default:
            //Do Nothing
            _ = 0
            break;
            
        }
        
        
        
    }
    
    
}
