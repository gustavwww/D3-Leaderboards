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
    
    let array = ["LeaderBoards", "Player Lookup", "Settings", "Account", "EU"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "MenuCell", for: indexPath) as? MenuCell {
            
            cell.configureCell(array[indexPath.row])
            
            return cell
        }
        
        return MenuCell()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        
        return array.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
    }
    
    
    @IBAction func exitPressed(_ sender: UIButton) {
        
        dismiss(animated: false, completion: nil)
        
    }
    
}
