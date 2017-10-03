//
//  OAuth.swift
//  Twift
//
//  Created by Taillook on 2017/09/26.
//  Copyright © 2017年 Taillook. All rights reserved.
//

import OAuthSwift

class OAuthTwitter {
    var oauthSwift: OAuth1Swift!
    let shared = Common.shared
    let ud = Common.shared.userDefaults
    
    init() {
        oauthSwift = OAuth1Swift(
            consumerKey:    "W2tOU5CYeOnACCEcYfZvv9jbq",
            consumerSecret: "cMZOWZzuo0E1oHzYUjyofmmj1CVP6DKYkm0D9eBmzDOrQCeSpn",
            requestTokenUrl: "https://api.twitter.com/oauth/request_token",
            authorizeUrl:    "https://api.twitter.com/oauth/authorize",
            accessTokenUrl:  "https://api.twitter.com/oauth/access_token"
        )
        oauthSwift.client.credential.oauthToken = shared.currentUser["token"]!
        oauthSwift.client.credential.oauthTokenSecret = shared.currentUser["tokenSecret"]!
    }
    
    func doOAuthTwitter(vc: UIViewController){
        oauthSwift.authorizeURLHandler = getURLHandler(vc: vc)
        let _ = oauthSwift.authorize(
            withCallbackURL: URL(string: "Twift://oauth-callback")!,
            success: { credential, response, parameters in
                var users = [Any]()
                if self.ud.object(forKey: "users") != nil {
                    users = self.ud.object(forKey: "users") as! [Any]
                }else {
                    self.ud.set(users, forKey: "users")
                }
                
                users.append(["token": credential.oauthToken, "tokenSecret": credential.oauthTokenSecret, "id": parameters["user_id"] as! String, "name": parameters["screen_name"] as! String])
                self.ud.set(users, forKey: "users")
                self.ud.synchronize()
                
                self.shared.currentUser = ["token": credential.oauthToken, "tokenSecret": credential.oauthTokenSecret]
                
                vc.navigationController?.popViewController(animated: true)
        },
            failure: { error in
                print(error.description)
        }
        )
    }
    
    func getURLHandler(vc: UIViewController) -> OAuthSwiftURLHandlerType {
        if #available(iOS 9.0, *) {
            let handler = SafariURLHandler(viewController: vc, oauthSwift: oauthSwift)
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
