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
    
    //@IBOutlet weak var tanoshimiDateField: NSTextField!
    //@IBOutlet weak var daysLeftField: NSTextField!
    //@IBOutlet weak var emojiField: NSTextField!
    
    let widgetAllowsEditing = true
    
    dynamic var tanoshimiDate: Date?
    dynamic var tanoshimiDateText: String?
    dynamic var daysLeftText: String?

    override var nibName: String? {
        return "TodayViewController"
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        self.registerDefaults()
    }
    
    override init?(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
        self.registerDefaults()
    }
    
    override func awakeFromNib() {
        self.registerDefaults()
        
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
        self.tanoshimiDateText = self.getTanoshimiDateText()
        self.daysLeftText = self.getDaysLeftText()
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
        self.isEditing = false
    }
    
    override func viewDidDisappear() {
        // remove observer before deallocation
        self.removeObserver(self, forKeyPath: "tanoshimiDate")
        
        // remove bindings
        self.unbind("tanoshimiDate")
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






































