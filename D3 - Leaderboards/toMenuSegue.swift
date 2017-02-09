//
//  toMenuSegue.swift
//  D3 - Leaderboards
//
//  Created by Gustav Wadström on 2017-02-07.
//  Copyright © 2017 Gustav Wadström. All rights reserved.
//

import UIKit

class toMenuSegue: UIStoryboardSegue {

    
    override func perform() {
        
        let sourceView = source.view!
        let destView = destination.view!
        
        let screenHeight = UIScreen.main.bounds.height
        let screenWidht = UIScreen.main.bounds.width
        
        destView.center = CGPoint(x: -screenWidht / 2, y: screenHeight / 2)
        
        let window = UIApplication.shared.keyWindow
        window?.insertSubview(destView, aboveSubview: sourceView)
        
        UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseOut, animations: {
            
            destView.center = CGPoint(x: screenWidht / 2, y: screenHeight / 2)
            
        }) { (Complete) in
            
            let vc = self.destination
            vc.modalPresentationStyle = .overCurrentContext
            
            self.source.present(vc, animated: false, completion: nil)
            
        }
        
    }
    
    
}
