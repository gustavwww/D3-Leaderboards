//
//  OAuthTokenGenerator.swift
//  D3 - Leaderboards
//
//  Created by Gustav Wadström on 2017-05-15.
//  Copyright © 2017 Gustav Wadström. All rights reserved.
//

import Foundation
import OAuthSwift

class OAuthTokenGenerator {
    
    var oauthswift: OAuth2Swift?
    
    let consumerKey = "v5p92v64hfnd8nmy8vjtzs2429ry5nmc"
    let consumerSecret = "VkXvmEXAS8AdFqUkAMJzFHMEPvfFbGU4"
    
    func setup(region: String) {
        
        oauthswift = OAuth2Swift(consumerKey: consumerKey, consumerSecret: consumerSecret, authorizeUrl: "https://\(region).battle.net/oauth/authorize", accessTokenUrl: "https://eu.battle.net/oauth/token", responseType: "code")
        
    }
    
    func authorize(completed: @escaping () -> (), failed: @escaping () -> ()) {
        
        oauthswift?.authorize(withCallbackURL: "https://oauth.click/d3leaderboards/oauth-callback/bnet", scope: "", state: "BATTLENET", success: { (credential, response, parameters) in
            
            Constants.shared.access_token = "?access_token=" + credential.oauthToken
            Constants.shared.seasonURL = "https://eu.api.battle.net/data/d3/season/\(Constants.shared.access_token)"
            completed()
            
        }, failure: { (error) in
            
            print(error.description)
            failed()
        })
        
        
    }

}
