//
//  Messages.swift
//  Tanoshimi
//
//  Created by Philipp Brendel on 04.06.17.
//  Copyright © 2017 Entenwolf Software. All rights reserved.
//

import Foundation

class MessageFormatter {
    func getTanoshimiDateText(tanoshimiDate date: Date?) -> String {
        if let tanoshimiDate = date {
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
    
    func getDaysLeftText(tanoshimiDate date: Date?) -> String {
        if let tanoshimiDate = date {
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
}
































