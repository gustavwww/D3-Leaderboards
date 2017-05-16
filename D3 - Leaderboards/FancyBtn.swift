//
//  FancyBtn.swift
//  D3 - Leaderboards
//
//  Created by Gustav Wadström on 2017-05-16.
//  Copyright © 2017 Gustav Wadström. All rights reserved.
//

import UIKit

@IBDesignable
class FancyBtn: UIButton {

    @IBInspectable var cornerRadius: CGFloat = 0 {
        
        didSet {
            layer.cornerRadius = cornerRadius
        }
        
    }

}
