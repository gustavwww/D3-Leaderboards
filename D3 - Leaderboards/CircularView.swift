//
//  CircularView.swift
//  D3 - Leaderboards
//
//  Created by Gustav Wadström on 2017-02-13.
//  Copyright © 2017 Gustav Wadström. All rights reserved.
//

import UIKit

class CircularView: UIView, Shadow {

    @IBInspectable var border: Bool = false
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        prepareView()
        
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        
        prepareView()
        
    }
    
    func prepareView() {
    
        layer.cornerRadius = bounds.height / 2
        putOffsetShadow(offset: CGSize(width: 2, height: 3))
        
        if border {
            
            layer.borderWidth = 4
            layer.borderColor = UIColor.white.cgColor
            
        }
    
    }
    
    
    
    
}
