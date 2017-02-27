//
//  toHeroSegue.swift
//  D3 - Leaderboards
//
//  Created by Gustav Wadström on 2017-02-13.
//  Copyright © 2017 Gustav Wadström. All rights reserved.
//

import UIKit

class toHeroSegue: UIStoryboardSegue {

    override func perform() {
        
        let sourceView = source.view!
        let destView = destination.view!
        
        let screenHeight = UIScreen.main.bounds.height
        let screenWidth = UIScreen.main.bounds.width
        
        destView.center = CGPoint(x: screenWidth + (screenWidth / 2), y: screenHeight / 2)
        
        let window = UIApplication.shared.keyWindow
        window?.insertSubview(destView, aboveSubview: sourceView)
        
        UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseOut, animations: {
            
            destView.center = CGPoint(x: screenWidth / 2, y: screenHeight / 2)
            sourceView.center = CGPoint(x: (screenWidth / 2) - 50, y: screenHeight / 2)
            
            
        }) { (Complete) in
            
            _ = self.source.navigationController?.popToViewController(self.destination, animated: false)
            
        }
        
    }
    
}
