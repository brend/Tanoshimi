//
//  TodayViewController.swift
//  TanoshimiWidget
//
//  Created by Philipp Brendel on 27.05.17.
//  Copyright © 2017 Entenwolf Software. All rights reserved.
//

import Cocoa
import NotificationCenter

class TodayViewController: NSViewController, NCWidgetProviding {
    
    let widgetAllowsEditing = true
    
    dynamic var tanoshimiDate: Date?
    
    dynamic var tanoshimiDateText: String?
    dynamic var daysLeftText: String?
    
    let messages = MessageFormatter()

    override var nibName: String? {
        return "TodayViewController"
    }
    
    override func awakeFromNib() {
        registerDefaults()
        
        self.bind("tanoshimiDate", to: UserDefaults.standard, withKeyPath: "date", options: nil)
        
        // observe date change to update ui
        self.addObserver(self, forKeyPath: "tanoshimiDate", options: .new, context: &myContext)
    }
    
    private var myContext = 0
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        // update ui in case of date change
        if context == &myContext {
            updateUserInterface()
        } else {
            super.observeValue(forKeyPath: keyPath, of: object, change: change, context: context)
        }
    }
    
    func widgetPerformUpdate(completionHandler: (@escaping (NCUpdateResult) -> Void)) {
        updateUserInterface()
        completionHandler(.newData)
    }
    
    func updateUserInterface() {
        self.tanoshimiDateText = messages.getTanoshimiDateText(tanoshimiDate: self.tanoshimiDate)
        self.daysLeftText = messages.getDaysLeftText(tanoshimiDate: self.tanoshimiDate)
    }
    
    dynamic var isEditing = false
    
    func widgetDidBeginEditing() {
        self.isEditing = true
    }
    
    func widgetDidEndEditing() {
        self.isEditing = false
    }
    
    override func viewDidDisappear() {
        // remove observer before deallocation
        self.removeObserver(self, forKeyPath: "tanoshimiDate")
        
        // remove bindings
        self.unbind("tanoshimiDate")
    }
}






































