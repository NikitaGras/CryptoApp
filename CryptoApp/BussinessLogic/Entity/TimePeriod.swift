//
//  TimePeriod.swift
//  CryptoApp
//
//  Created by Nikita Gras on 06.06.2021.
//

import Foundation

enum TimePeriod {
    case day
    case week
    case threeMonths
    case year
    case allTime
    
    var title: String {
        switch self {
        case .day:
            return "1Д"
        case .week:
            return "1Н"
        case .threeMonths:
            return "3М"
        case .year:
            return "1Г"
        case .allTime:
            return "Все"
        }
    }
    
    static func getCases()  -> [TimePeriod] {
        var array = [TimePeriod]()
        array.append(TimePeriod.day)
        array.append(TimePeriod.week)
        array.append(TimePeriod.threeMonths)
        array.append(TimePeriod.year)
        array.append(TimePeriod.allTime)
        return array
    }
    
    static func getTitles() -> [String] {
        var titles = [String]()
        titles.append(TimePeriod.day.title)
        titles.append(TimePeriod.week.title)
        titles.append(TimePeriod.threeMonths.title)
        titles.append(TimePeriod.year.title)
        titles.append(TimePeriod.allTime.title)
        return titles
    }
}
