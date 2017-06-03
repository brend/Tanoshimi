//
//  Presets.swift
//  Tanoshimi
//
//  Created by Philipp Brendel on 03.06.17.
//  Copyright © 2017 Entenwolf Software. All rights reserved.
//

import Foundation

class Presets {
    var date: Date
    var emoji: String
    
    init() {
        // register defaults
        let defaults = UserDefaults.standard
        let defaultPrefsFile = Bundle.main.url(forResource: "Resources", withExtension: "plist")
        if let defaultPrefs = NSDictionary(contentsOf: defaultPrefsFile!) {
            let prefsdict = defaultPrefs as! [String : Any]
            
            defaults.register(defaults: prefsdict)
        }
        
        // apply defaults
        self.date = defaults.object(forKey: "date") as! Date
        self.emoji = defaults.string(forKey: "emoji")!
    }
    
    func registerDefaults() {
        
    }
    
    func save() {
        let defaults = UserDefaults.standard

        defaults.setValue(date, forKey: "date")
        defaults.setValue(emoji, forKey: "emoji")
    }
}

































