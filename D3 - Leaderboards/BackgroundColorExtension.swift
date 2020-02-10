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
            backgroundColor = UIColor(red:0.67, green:0.43, blue:0.07, alpha:0.3)
            layer.borderColor = UIColor(red: 0.67, green: 0.43, blue: 0.07, alpha: 0.5).cgColor
            break;
            
        case "green":
            backgroundColor = UIColor(red:0.16, green:0.89, blue:0.11, alpha:0.1)
            layer.borderColor = UIColor(red:0.16, green:0.89, blue:0.11, alpha:0.5).cgColor
            break;
            
        case "yellow":
            backgroundColor = UIColor(red:0.96, green:0.95, blue:0.13, alpha:0.1)
            layer.borderColor = UIColor(red:0.96, green:0.95, blue:0.13, alpha:0.5).cgColor
            break;
            
        case "white":
            backgroundColor = UIColor(red:1.00, green:1.00, blue:1.00, alpha:0.2)
            layer.borderColor = UIColor(red:1.00, green:1.00, blue:1.00, alpha:0.4).cgColor
            break;
            
        default:
            //Do Nothing
            _ = 0
            break;
            
        }
        layer.borderWidth = 1
        layer.cornerRadius = 5
        
        
    }
    
    
}
