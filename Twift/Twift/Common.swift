//
//  Comon.swift
//  Twift
//
//  Created by Taillook on 2017/09/26.
//  Copyright © 2017年 Taillook. All rights reserved.
//

import Foundation

class Common {
    let consumerData: [String: String] =
        ["consumerKey":"W2tOU5CYeOnACCEcYfZvv9jbq", "consumerSecret":"cMZOWZzuo0E1oHzYUjyofmmj1CVP6DKYkm0D9eBmzDOrQCeSpn"]
    var currentOAuthData: [String: String] =
        ["OAuthKey":"", "OAuthSecret":""]
    let userDefaults = UserDefaults.standard
    static let shared = Common()
    private init() {
        if ((self.userDefaults.object(forKey: "currentUser")) != nil) {
            self.currentOAuthData = self.userDefaults.object(forKey: "currentUser") as! [String: String]
        }else {
            self.userDefaults.set(self.currentOAuthData, forKey: "currentUser")
            self.userDefaults.synchronize()
        }
    }
}
