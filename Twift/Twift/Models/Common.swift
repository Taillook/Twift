//
//  Comon.swift
//  Twift
//
//  Created by Taillook on 2017/09/26.
//  Copyright © 2017年 Taillook. All rights reserved.
//

import OAuthSwift

class Common {
    let consumerData: [String: String] =
        ["consumerKey":"W2tOU5CYeOnACCEcYfZvv9jbq", "consumerSecret":"cMZOWZzuo0E1oHzYUjyofmmj1CVP6DKYkm0D9eBmzDOrQCeSpn"]
    let userDefaults = UserDefaults.standard
    var currentUser: [String: String] = ["token":"", "tokenSecret":""] {
        didSet {
            self.userDefaults.set(currentUser, forKey: "currentUser")
            self.userDefaults.synchronize()
        }
    }
    static let shared = Common()
    private init() {
        if ((userDefaults.object(forKey: "currentUser")) != nil) {
            self.currentUser = userDefaults.object(forKey: "currentUser") as! [String: String]
        }
    }
}
