//
//  Requests.swift
//  Twift
//
//  Created by Taillook on 2017/10/01.
//  Copyright © 2017年 Taillook. All rights reserved.
//

extension OAuthTwitter {
    func fetchHomeTimeLine(callback: @escaping (String) -> Void) {
        _ = oauthSwift.client.get("https://api.twitter.com/1.1/statuses/home_timeline.json", parameters: ["count": "20"], success: { response in
            callback(response.dataString()!)
        }, failure: { error in
            print(error)
        })
    }
    
    func verifyCredentials(callback: @escaping (String) -> Void) {
        _ = oauthSwift.client.get("https://api.twitter.com/1.1/account/verify_credentials.json", parameters: [:], success: { response in
            callback(response.dataString()!)
        }, failure: { error in
            print(error)
        })
    }
    
    func showUser(name:String, callback: @escaping (String) -> Void) {
        _ = oauthSwift.client.get("https://api.twitter.com/1.1/users/show.json", parameters: ["screen_name": name], success: { response in
            callback(response.dataString()!)
        }, failure: { error in
            print(error)
        })
    }
    
    func tweetDetail(id:String, callback: @escaping (String) -> Void) {
        _ = oauthSwift.client.get("https://api.twitter.com/1.1/statuses/show.json", parameters: ["id": id], success: { response in
            callback(response.dataString()!)
        }, failure: { error in
            print(error)
        })
    }
    
    func createFav(id:String) {
        _ = oauthSwift.client.post("https://api.twitter.com/1.1/favorites/create.json", parameters: ["id": id], success: { response in
            print(response.dataString()!)
        }, failure: { error in
            print(error)
        })
    }
    
    func createReTweet(id:String) {
        _ = oauthSwift.client.post("https://api.twitter.com/1.1/statuses/retweet/" + id + ".json", parameters: ["id": id], success: { response in
            print(response.dataString()!)
        }, failure: { error in
            print(error)
        })
    }
}
