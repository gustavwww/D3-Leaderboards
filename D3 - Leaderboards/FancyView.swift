//
//  FancyView.swift
//  D3 - Leaderboards
//
//  Created by Gustav Wadström on 2017-02-24.
//  Copyright © 2017 Gustav Wadström. All rights reserved.
//

import UIKit

@IBDesignable
class FancyView: UIView, Shadow {

    
    @IBInspectable var cornerRadius: CGFloat = 0 {
        
        didSet {
            layer.cornerRadius = cornerRadius
        }
        
    }
    
    @IBInspectable var offsetShadow: CGSize = CGSize.zero {
        
        didSet {
            putOffsetShadow(offset: offsetShadow)
        }
        
    }
    
    @IBInspectable var radiusShadow: CGFloat = 0 {
        
        didSet {
            putRadiusShadow(radius: radiusShadow)
        }
        
    }
    
    @IBInspectable var borderWidth: CGFloat = 0 {
        
        didSet {
            layer.borderWidth = borderWidth
        }
        
    }
    
    @IBInspectable var borderColor: UIColor = UIColor.black {
        
        didSet {
            layer.borderColor = borderColor.cgColor
        }
        
    }
    
    @IBInspectable var rotation: Double = 0 {
        
        didSet {
            let transformation = CGAffineTransform(rotationAngle: CGFloat(M_PI * (rotation/180)))
            transform = transformation
        }
        
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    

}
