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
    
    @IBOutlet var tanoshimiDateField: NSTextField!
    @IBOutlet var daysLeftField: NSTextField!

    override var nibName: String? {
        return "TodayViewController"
    }

    func widgetPerformUpdate(completionHandler: (@escaping (NCUpdateResult) -> Void)) {
        // Update your data and prepare for a snapshot. Call completion handler when you are done
        // with NoData if nothing has changed or NewData if there is new data since the last
        // time we called you
        //completionHandler(.noData)
        
        let tanoshimiDateText: String
        let daysLeftText: String
        
        if let tanoshimiDate = getTanoshimiDate() {
            let timeLeft = tanoshimiDate.timeIntervalSince(Date())
            let daysLeft = Int(ceil(timeLeft / (24 * 3600)))
            
            if daysLeft <= 0 {
                daysLeftText = NSLocalizedString("TanoshimiArrived", comment: "Oshiri")
                tanoshimiDateText = ""
            } else {
                let formattedDate = formatDate(date: tanoshimiDate)
                
                // daysLeftText = "\(daysLeft) days left"
                let daysLeftFormat = NSLocalizedString("TanoshimiDaysLeft", comment: "Butt")
                let untilFormat = NSLocalizedString("TanoshimiDate", comment: "Popo")
                
                daysLeftText = String(format: daysLeftFormat, daysLeft)
                tanoshimiDateText = String(format: untilFormat, formattedDate)
            }
        } else {
            tanoshimiDateText = "n/a"
            daysLeftText = "n/a"
        }
        
        tanoshimiDateField.stringValue = tanoshimiDateText
        daysLeftField.stringValue = daysLeftText
        
        completionHandler(.newData)
    }

    func getTanoshimiDate() -> Date? {
        var dict: NSDictionary? = nil
        
        if let path = Bundle.main.path(forResource: "Resources", ofType: "plist") {
            dict = NSDictionary(contentsOfFile: path)
        }
        
        if let resources = dict {
            return resources.value(forKey: "TanoshimiDate") as? Date
        }
        
        return nil
    }
    
    func formatDate(date: Date) -> String {
        let formatter = DateFormatter()
        
        formatter.dateStyle = .short
        formatter.timeStyle = .none
        
        return formatter.string(from: date)
    }
}
