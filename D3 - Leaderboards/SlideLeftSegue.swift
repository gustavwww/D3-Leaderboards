//
//  SlideLeftSegue.swift
//  D3 - Leaderboards
//
//  Created by Gustav Wadström on 2017-11-04.
//  Copyright © 2017 Gustav Wadström. All rights reserved.
//

import UIKit

class SlideLeftSegue: UIStoryboardSegue {
    
    override func perform() {
        
        let sourceView = source.view!
        let destView = destination.view!
        
        let screenWidth = UIScreen.main.bounds.width
        let screenHeight = UIScreen.main.bounds.height
        
        destView.center = CGPoint(x: (screenWidth / 2) - 100, y: screenHeight / 2)
        
        let window = UIApplication.shared.keyWindow!
        window.insertSubview(destView, belowSubview: sourceView)
        
        UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseOut, animations: {
            
            destView.center = CGPoint(x: screenWidth / 2, y: screenHeight / 2)
            sourceView.center = CGPoint(x: screenWidth + (screenWidth / 2), y: screenHeight / 2)
            
            
            
        }, completion: { (completed) in
            
            self.source.dismiss(animated: false, completion: nil)
                
        })
        
        
            
        }
        
        
        
    }
