//
//  ViewController.swift
//  Tanoshimi
//
//  Created by Philipp Brendel on 27.05.17.
//  Copyright © 2017 Entenwolf Software. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {
    
    dynamic var daysLeftText: String?
    dynamic var tanoshimiDateText: String?
    
    dynamic var tanoshimiDate: Date?
    
    let messages = MessageFormatter()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        registerDefaults()
        
        bind("tanoshimiDate", to: UserDefaults.standard, withKeyPath: "date", options: nil)
        
        updateUI()
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }
    
    func updateUI() {
        daysLeftText = messages.getDaysLeftText(tanoshimiDate: tanoshimiDate)
        tanoshimiDateText = messages.getTanoshimiDateText(tanoshimiDate: tanoshimiDate)
    }
}







































