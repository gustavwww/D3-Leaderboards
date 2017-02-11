//
//  MenuVC.swift
//  D3 - Leaderboards
//
//  Created by Gustav Wadström on 2017-02-07.
//  Copyright © 2017 Gustav Wadström. All rights reserved.
//

import UIKit

class MenuVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    var fromVC: UIViewController!
    
    let list = ["LeaderBoards"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "MenuCell", for: indexPath) as? MenuCell {
            
            cell.configureCell(list[indexPath.row])
            
            return cell
        }
        
        return MenuCell()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        
        return list.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        closeMenu()
        
        
    }
    
    
    @IBAction func exitPressed(_ sender: UIButton) {
        
        closeMenu()
        
    }
    @IBAction func backBtn(_ sender: UIButton) {
        
        closeMenu()
        
    }
    
    func closeMenu() {
        
        let screenWidth = UIScreen.main.bounds.width
        let screenHeight = UIScreen.main.bounds.height
        
        UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseIn, animations: {
            
            self.view.center = CGPoint(x: -screenWidth / 2, y: screenHeight / 2)
            
        }) { (Complete) in
            
            self.dismiss(animated: false, completion: nil)
            
        }
        
    }
    
    
    
    
}
