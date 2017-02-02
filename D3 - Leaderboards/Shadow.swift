//
//  Shadow.swift
//  D3 - Leaderboards
//
//  Created by Gustav Wadström on 2017-02-02.
//  Copyright © 2017 Gustav Wadström. All rights reserved.
//

import UIKit

protocol Shadow {}

extension Shadow where Self: UIView {
    
    func putRadiusShadow(radius: CGFloat) {
        
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.8
        layer.shadowRadius = radius
        
    }
    
    func putOffsetShadow(offset: CGSize) {
        
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.8
        layer.shadowOffset = offset
        
        
    }
    
}
