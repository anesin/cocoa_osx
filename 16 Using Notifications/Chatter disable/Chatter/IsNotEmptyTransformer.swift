//
//  IsNotEmptyTransformer.swift
//  Chatter
//
//  Created by anesin on 2016. 1. 31..
//  Copyright © 2016년 anesin. All rights reserved.
//

import Cocoa

class IsNotEmptyTransformer: NSValueTransformer {
    
    override func transformedValue(value: AnyObject?) -> AnyObject? {
        guard let message = value as! String? else {
            return false
        }
        return !message.isEmpty
    }
    
}
