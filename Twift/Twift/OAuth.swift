//
//  OAuth.swift
//  Twift
//
//  Created by Taillook on 2017/09/26.
//  Copyright © 2017年 Taillook. All rights reserved.
//

import Foundation
import OAuthSwift

class OAuth {
    var oauthswift: OAuthSwift?
    let consumerData: [String:String] = Common.shared.consumerData
    let ud: UserDefaults = Common.shared.userDefaults
    
    func doOAuthTwitter(vc: UIViewController){
        let oauthswift = OAuth1Swift(
            consumerKey:    consumerData["consumerKey"]!,
            consumerSecret: consumerData["consumerSecret"]!,
            requestTokenUrl: "https://api.twitter.com/oauth/request_token",
            authorizeUrl:    "https://api.twitter.com/oauth/authorize",
            accessTokenUrl:  "https://api.twitter.com/oauth/access_token"
        )
        self.oauthswift = oauthswift
        oauthswift.authorizeURLHandler = getURLHandler(vc: vc)
        let _ = oauthswift.authorize(
            withCallbackURL: URL(string: "Twift://oauth-callback")!,
            success: { credential, response, parameters in
                var users: [Any] = []
                if ((self.ud.object(forKey: "users")) != nil) {
                    users = self.ud.object(forKey: "users") as! [Any]
                }else {
                    self.ud.set(users, forKey: "users")
                }
                
                users.append(["oauth_token": credential.oauthToken, "oauth_token_secret": credential.oauthTokenSecret])
                self.ud.set(users, forKey: "users")
                self.ud.synchronize()
        },
            failure: { error in
                print(error.description)
        }
        )
    }
    
    func getURLHandler(vc: UIViewController) -> OAuthSwiftURLHandlerType {
        if #available(iOS 9.0, *) {
            let handler = SafariURLHandler(viewController: vc, oauthSwift: self.oauthswift!)
            handler.presentCompletion = {
                print("Safari presented")
            }
            handler.dismissCompletion = {
                print("Safari dismissed")
            }
            return handler
        }
        return OAuthSwiftOpenURLExternally.sharedInstance
    }
    
}
