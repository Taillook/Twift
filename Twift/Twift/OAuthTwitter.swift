//
//  OAuth.swift
//  Twift
//
//  Created by Taillook on 2017/09/26.
//  Copyright © 2017年 Taillook. All rights reserved.
//

import Foundation
import OAuthSwift

class OAuthTwitter {
    var oauthswift = OAuth1Swift(
        consumerKey:    "W2tOU5CYeOnACCEcYfZvv9jbq",
        consumerSecret: "cMZOWZzuo0E1oHzYUjyofmmj1CVP6DKYkm0D9eBmzDOrQCeSpn",
        requestTokenUrl: "https://api.twitter.com/oauth/request_token",
        authorizeUrl:    "https://api.twitter.com/oauth/authorize",
        accessTokenUrl:  "https://api.twitter.com/oauth/access_token"
    )
    let shared = Common.shared
    let ud: UserDefaults = Common.shared.userDefaults
    
    init() {
        //self.oauthswift.client.credential.oauthToken = "4915971073-INK5QZuYRfYXasxxqLr46m5V2lXqbOGquT7olwb"
        //self.oauthswift.client.credential.oauthTokenSecret = "8AZfCBFMNumRm0PlDHJEZ3aUczD0JHVIpp1PfIx8ptD5p"
        self.oauthswift.client.credential.oauthToken = shared.currentUser["token"]!
        self.oauthswift.client.credential.oauthTokenSecret = shared.currentUser["tokenSecret"]!
    }
    
    func doOAuthTwitter(vc: UIViewController){
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
                
                users.append(["token": credential.oauthToken, "tokenSecret": credential.oauthTokenSecret, "id": parameters["user_id"] as! String, "name": parameters["screen_name"] as! String])
                self.ud.set(users, forKey: "users")
                self.ud.synchronize()
                
                self.shared.currentUser = ["token": credential.oauthToken, "tokenSecret": credential.oauthTokenSecret]
        },
            failure: { error in
                print(error.description)
        }
        )
    }
    
    func getURLHandler(vc: UIViewController) -> OAuthSwiftURLHandlerType {
        if #available(iOS 9.0, *) {
            let handler = SafariURLHandler(viewController: vc, oauthSwift: self.oauthswift)
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
    
    func fetchHomeTimeLine() {
        let _ = self.oauthswift.client.get("https://api.twitter.com/1.1/statuses/home_timeline.json", parameters: ["exclude_replies":"true"], success: { response in
            let jsonDict = try? response.jsonObject()
            print(jsonDict as Any)
        }, failure: { error in
            print(error)
        })
    }
    
    func verifyCredentials() {
        let _ = self.oauthswift.client.get("https://api.twitter.com/1.1/account/verify_credentials.json", parameters: [:], success: { response in
            let jsonDict = try? response.jsonObject()
            print(jsonDict as Any)
        }, failure: { error in
            print(error)
        })
    }
    
    func showUser(name:String, callback: @escaping (String) -> Void) {
        let _ = self.oauthswift.client.get("https://api.twitter.com/1.1/users/show.json", parameters: ["screen_name": name], success: { response in
            callback(response.dataString()!)
        }, failure: { error in
            print(error)
        })
    }
}
