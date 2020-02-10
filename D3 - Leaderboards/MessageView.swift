//
//  MessageView.swift
//  D3 - Leaderboards
//
//  Created by Gustav Wadström on 2017-11-09.
//  Copyright © 2017 Gustav Wadström. All rights reserved.
//

import UIKit

enum Message: String {
    case NoNecromancer = "Necromancer not available under season 11"
}

class MessageView: UIView {
    
    private var onView: UIView!

    func setupView(onView: UIView, msg: Message) {
        
        self.onView = onView
        
        //Setup self
        layer.backgroundColor = UIColor.black.cgColor
        layer.opacity = 0.4
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowRadius = 2
        
        center = CGPoint(x: onView.bounds.width / 2, y: onView.bounds.height / 2)
        
        //Setup label
        let label = UILabel(frame: CGRect(x: bounds.width / 2, y: 20, width: bounds.width - 20, height: 21))
        let font = UIFont(name: "Avenir Next", size: 18)
        
        label.textColor = UIColor.white
        label.textAlignment = .center
        label.text = msg.rawValue
        label.font = font
        
        onView.addSubview(self)
    }
    
    func removeView() {
        removeFromSuperview()
    }

}
