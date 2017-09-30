//
//  DeviceUserModel.swift
//  Twift
//
//  Created by Taillook on 2017/09/26.
//  Copyright © 2017年 Taillook. All rights reserved.
//

import Foundation
import ObjectMapper

class User: Mappable {
    var name: String?
    var screenName: String?
    var profileImageUrl: String?
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        name            <- map["name"]
        screenName      <- map["screen_name"]
        profileImageUrl <- map["profile_image_url_https"]
    }
}
