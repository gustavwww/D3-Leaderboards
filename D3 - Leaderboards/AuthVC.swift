//
//  OAuthViewController.swift
//  D3 - Leaderboards
//
//  Created by Gustav Wadström on 2017-05-15.
//  Copyright © 2017 Gustav Wadström. All rights reserved.
//

import UIKit
import GoogleMobileAds

class AuthVC: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    var tokenGen = OAuthTokenGenerator()
    
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var regionBtn: FancyBtn!
    @IBOutlet weak var errorMsg: UILabel!
    
    let regions = ["EU", "US", "KR", "TW"]
    var currentSelectedRegion = "eu"
    
    @IBOutlet weak var bannerView: GADBannerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupBanner()
        
        pickerView.delegate = self
        pickerView.dataSource = self
        
    }
    
    func setupBanner() {
        
        bannerView.adUnitID = "ca-app-pub-3940256099942544/2934735716" //"ca-app-pub-3305261733368372/7332501643"
        bannerView.rootViewController = self
        bannerView.load(GADRequest())
        
    }
    
    @IBAction func regionBtnPressed(_ sender: FancyBtn) {
        
        pickerView.isHidden = false
        
    }

    @IBAction func authBtnPressed(_ sender: FancyBtn) {
        
        errorMsg.isHidden = true
        
        tokenGen.setup(region: currentSelectedRegion)
        tokenGen.authorize(completed: { 
            
            //Success - Transport to BoardVC
            self.performSegue(withIdentifier: "toBoardVC", sender: nil)
            
        }, failed: {
            //Failure - Failure Message
            
            self.errorMsg.isHidden = false
            
        })
        
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        
        return regions.count
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        //Row selected
        
        let selection = regions[row]
        currentSelectedRegion = selection.lowercased()
        
        regionBtn.setTitle(selection, for: .normal)
        
        pickerView.isHidden = true
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        
        return regions[row]
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        
        return 1
    }
    
}
    
    
    
    
    
    
    
    
    
    
    
    
    
    

