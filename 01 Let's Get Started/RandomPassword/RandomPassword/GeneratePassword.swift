//
//  GeneratePassword.swift
//  RandomPassword
//
//  Created by anesin on 2015. 11. 6..
//  Copyright © 2015년 anesin. All rights reserved.
//

import Foundation

private let characters = Array(("0123456789abcdefghijklmnopqrstuvwxyz" + "ABCDEFGHIJKLMNOPQRSTUVWXYZ").characters)  // Swift 2

func generateRandomString(length: Int) -> String {
    var string = ""
    for _ in 0 ..< length {
        string.append(generateRandomCharacter())
    }
    
    return string
}

func generateRandomCharacter() -> Character {
    let index = Int(arc4random_uniform(UInt32(characters.count)))
    let character = characters[index]
    return character
}