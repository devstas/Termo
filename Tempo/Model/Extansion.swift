//
//  BasicExtantion.swift
//  Tempo
//
//  Created by Devolper on 23.07.18.
//  Copyright © 2018 Devolper. All rights reserved.
//

import Foundation
import UIKit


extension Double {
    
    func unixDateToDayOfWeek() -> String {
        let dateTime = NSDate(timeIntervalSince1970: self)
        //indexPath.row == 0 ? "Завтра" :
        let dateFormatter  = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ru_RU")
        let calendar = Calendar(identifier: .gregorian)
        let weekDay = calendar.component(.weekday, from: dateTime as Date)
        return dateFormatter.weekdaySymbols[weekDay-1].capitalized
    }
    
    func unixDateToString() -> String {
        let dateTime = NSDate(timeIntervalSince1970: self)
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ru_RU")
        dateFormatter.dateStyle = .long
        dateFormatter.timeStyle = .none
        dateFormatter.setLocalizedDateFormatFromTemplate("MMMMd")
        return dateFormatter.string(from: dateTime as Date)
    }

    func unixTimeToString() -> String {
        let time = NSDate(timeIntervalSince1970: self)
        let dateFormatter = DateFormatter()
        dateFormatter.locale = NSLocale(localeIdentifier: NSLocale.system.identifier) as Locale
        dateFormatter.dateFormat = "hh:mm a"
        let dateAsString = dateFormatter.string(from: time as Date)
        dateFormatter.dateFormat = "h:mm a"
        let date = dateFormatter.date(from: dateAsString)
        dateFormatter.dateFormat = "HH:mm"
        let date24 = dateFormatter.string(from: date!)
        return date24
    }
    
}

extension Notification.Name {
    static let locationIsUpdate = Notification.Name("locationIsUpdate")
}
