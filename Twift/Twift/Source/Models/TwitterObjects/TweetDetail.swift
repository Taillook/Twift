//
//  TweetDetail.swift
//  Twift
//
//  Created by Taillook on 2017/10/01.
//  Copyright © 2017年 Taillook. All rights reserved.
//

import ObjectMapper

class TweetDetail: Mappable {
    var text:       String?
    var user:       User?
    var id:         String?
    var createdAt:  String?
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        text        <- map["text"]
        user        <- map["user"]
        id          <- map["id_str"]
        createdAt   <- map["created_at"]
    }
}
