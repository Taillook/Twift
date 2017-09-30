//
//  Dictionary+union.swift
//  Twift
//
//  Created by Taillook on 2017/09/30.
//  Copyright © 2017年 Taillook. All rights reserved.
//

import Foundation

public extension Dictionary {
    public func union(_ other: Dictionary) -> Dictionary {
        var tmp = self
        other.forEach { tmp[$0.0] = $0.1 }
        return tmp
    }
}
