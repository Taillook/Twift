//
//  Comon.swift
//  Twift
//
//  Created by Taillook on 2017/09/26.
//  Copyright © 2017年 Taillook. All rights reserved.
//

import OAuthSwift

class Common {
    let userDefaults = UserDefaults.standard
    var currentUser = ["token":"", "tokenSecret":""] {
        didSet {
            userDefaults.set(currentUser, forKey: "currentUser")
            userDefaults.synchronize()
        }
    }
    static let shared = Common()
    
    private init() {
        if userDefaults.object(forKey: "currentUser") != nil {
            currentUser = userDefaults.object(forKey: "currentUser") as! [String: String]
        }
    }
}
