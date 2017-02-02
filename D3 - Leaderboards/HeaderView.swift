//
//  HeaderView.swift
//  D3 - Leaderboards
//
//  Created by Gustav Wadström on 2017-02-02.
//  Copyright © 2017 Gustav Wadström. All rights reserved.
//

import UIKit

@IBDesignable
class HeaderView: UIView, Shadow {

    @IBInspectable var shadowRadius: CGFloat = 0 {
        
        didSet {
            
            putRadiusShadow(radius: shadowRadius)
            
        }
        
    }
    
    @IBInspectable var shadowOffset: CGSize = CGSize.zero {
        
        didSet {
            
            putOffsetShadow(offset: shadowOffset)
            
        }
        
        
    }
    

}
