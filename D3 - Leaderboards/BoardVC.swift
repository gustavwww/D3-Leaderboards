//
//  ViewController.swift
//  D3 - Leaderboards
//
//  Created by Gustav Wadström on 2017-02-02.
//  Copyright © 2017 Gustav Wadström. All rights reserved.
//

import UIKit
import Alamofire

class BoardVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    
    @IBOutlet weak var tableView: UITableView!
    
    var players = [Player]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    func fetchList(completed: @escaping () -> (), hardCore: Bool, classString: String) {
        
        let URL: String
        
        if hardCore {
            URL = Constants.shared.Hardcore_URL + classString
        } else {
            URL = Constants.shared.Soft_URL + classString
        }
        
        Alamofire.request(URL).responseJSON { response in
            
            
            let result = response.result
            
            if let dict = result.value as? Dictionary<String, AnyObject> {
                
                
                
            }
            
        }
        
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        
        return players.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "HeroCell", for: indexPath) as? HeroCell {
            
            cell.configureCell()
            
            return cell
        }
        return HeroCell()
    }

}

