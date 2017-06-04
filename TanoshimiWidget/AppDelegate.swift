//
//  AppDelegate.swift
//  Tanoshimi
//
//  Created by Philipp Brendel on 03.06.17.
//  Copyright © 2017 Entenwolf Software. All rights reserved.
//

import Cocoa

class AppDelegate: NSObject, NSApplicationDelegate {
    
    override func awakeFromNib() {
        self.registerDefaults()
    }
    
    func registerDefaults() {
        let defaults = UserDefaults.standard
        let defaultPrefsFile = Bundle.main.url(forResource: "Resources", withExtension: "plist")
        if let defaultPrefs = NSDictionary(contentsOf: defaultPrefsFile!) {
            let prefsdict = defaultPrefs as! [String : Any]
            
            defaults.register(defaults: prefsdict)
        }
    }
}

































