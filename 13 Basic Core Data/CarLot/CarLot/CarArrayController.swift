//
//  CarArrayController.swift
//  CarLot
//
//  Created by anesin on 2016. 1. 9..
//  Copyright © 2016년 anesin. All rights reserved.
//

import Cocoa

class CarArrayController: NSArrayController {

    override func newObject() -> AnyObject {
        let newObj = super.newObject() as! NSObject
        let now = NSDate()
        newObj.setValue(now, forKey: "datePurchased")
        return newObj
    }
}
