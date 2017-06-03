//
//  Presets.swift
//  Tanoshimi
//
//  Created by Philipp Brendel on 03.06.17.
//  Copyright © 2017 Entenwolf Software. All rights reserved.
//

import Foundation

class Presets {
    let date: Date
    let emoji: String
    
    init() {
        var dict: NSDictionary? = nil
        
        if let path = Bundle.main.path(forResource: "Resources", ofType: "plist") {
            dict = NSDictionary(contentsOfFile: path)
        }
        
        if let resources = dict {
            date = (resources.value(forKey: "TanoshimiDate") as? Date) ?? Date()
            emoji = (resources.value(forKey: "TanoshimiEmoji") as? String) ?? "😃"
        } else {
            date = Date.init()
            emoji = "😃"
        }
    }
}

































