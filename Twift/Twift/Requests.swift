//
//  Requests.swift
//  Twift
//
//  Created by Taillook on 2017/09/26.
//  Copyright © 2017年 Taillook. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper

class Requests {
    let ud: UserDefaults = Common.shared.userDefaults
    
    func getUserInfo() {
        var headers = [
            "screen_name": "Taillook",
            "include_rts": "false"
        ]
        headers["authorization"] = "OAuth oauth_consumer_key=\""+Common.shared.consumerData["consumerKey"]!+"\",oauth_token=\""+Common.shared.currentOAuthData["OAuthKey"]!+"\",oauth_signature_method=\"HMAC-SHA1\",oauth_timestamp=\""+String(Int(Date().timeIntervalSince1970))+"\",oauth_nonce=\"n6Sxbq\",oauth_version=\"1.0\",oauth_signature=\"<KEY>\""
        
        Alamofire.request("https://api.twitter.com/1.1/statuses/user_timeline.json", method: .get, parameters: ["screen_name": "Taillook", "count": "20"], headers: headers).responseJSON { response in
            if response.result.isSuccess {
                print(response.result.value as! String)
            }else{
                print("error")
            }
        }
    }
}
