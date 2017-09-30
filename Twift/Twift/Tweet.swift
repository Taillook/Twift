//
//  Tweet.swift
//  Twift
//
//  Created by Taillook on 2017/09/30.
//  Copyright © 2017年 Taillook. All rights reserved.
//

import Foundation
import ObjectMapper

class Tweet: Mappable {
    var text: String?
    var user: User?
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        text    <- map["text"]
        user    <- map["user"]
    }
}
