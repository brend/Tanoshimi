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
    
    @IBOutlet weak var tanoshimiDateField: NSTextField!
    @IBOutlet weak var daysLeftField: NSTextField!
    @IBOutlet weak var emojiField: NSTextField!
    
    let presets = Presets()

    override var nibName: String? {
        return "TodayViewController"
    }
    
    override func awakeFromNib() {
        // observe date change to update ui
        //self.addObserver(self, forKeyPath: "tanoshimiDate", options: .new, context: &myContext)
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
    
    var widgetAllowsEditing: Bool = true
    
    dynamic var tanoshimiDate: Date?
    
    dynamic var tanoshimiEmoji: String?

    func widgetPerformUpdate(completionHandler: (@escaping (NCUpdateResult) -> Void)) {
        updateUserInterface()
        completionHandler(.newData)
    }
    
    func updateUserInterface() {
        if self.tanoshimiDate == nil {
            self.tanoshimiDate = presets.date
        }
        
        if self.tanoshimiEmoji == nil {
            self.tanoshimiEmoji = presets.emoji
        }
        
        self.tanoshimiDateField.stringValue = self.getTanoshimiDateText()
        self.daysLeftField.stringValue = self.getDaysLeftText()
        self.emojiField.stringValue = self.tanoshimiEmoji!
    }
    
    func getTanoshimiDateText() -> String {
        if let tanoshimiDate = self.tanoshimiDate {
            let timeLeft = tanoshimiDate.timeIntervalSince(Date())
            let daysLeft = Int(ceil(timeLeft / (24 * 3600)))
            
            if daysLeft <= 0 {
                return ""
            } else {
                let formattedDate = formatDate(date: tanoshimiDate)
                
                let untilFormat = NSLocalizedString("TanoshimiDate", comment: "Popo")
                
                return String(format: untilFormat, formattedDate)
            }
        } else {
            return "n/a"
        }
    }
    
    func getDaysLeftText() -> String {
        if let tanoshimiDate = self.tanoshimiDate {
            let timeLeft = tanoshimiDate.timeIntervalSince(Date())
            let daysLeft = Int(ceil(timeLeft / (24 * 3600)))
            
            if daysLeft <= 0 {
                return NSLocalizedString("TanoshimiArrived", comment: "Oshiri")
            } else {
                let daysLeftFormat = NSLocalizedString("TanoshimiDaysLeft", comment: "Butt")
                
                return String(format: daysLeftFormat, daysLeft)
            }
        } else {
            return "n/a"
        }
    }
    
    func formatDate(date: Date) -> String {
        let formatter = DateFormatter()
        
        formatter.dateStyle = .short
        formatter.timeStyle = .none
        
        return formatter.string(from: date)
    }
    
    dynamic var isEditing = false
    
    func widgetDidBeginEditing() {
        self.isEditing = true
    }
    
    func widgetDidEndEditing() {
        // TODO: Cancel editing?
        self.isEditing = false
    }
}






































