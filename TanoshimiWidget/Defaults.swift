//
//  Defaults.swift
//  Tanoshimi
//
//  Created by Philipp Brendel on 04.06.17.
//  Copyright © 2017 Entenwolf Software. All rights reserved.
//

import Foundation

func registerDefaults() {
    let defaults = UserDefaults.standard
    let defaultPrefsFile = Bundle.main.url(forResource: "Defaults", withExtension: "plist")
    if let defaultPrefs = NSDictionary(contentsOf: defaultPrefsFile!) {
        let prefsdict = defaultPrefs as! [String : Any]
        
        defaults.register(defaults: prefsdict)
    }
}
