//
//  CalendarDateFormatter.swift
//  TODOMate
//
//  Created by 이나연 on 5/15/25.
//

import Foundation

final class CalendarDateFormatter {
    private let calendar: Calendar = {
            var calendar = Calendar(identifier: .gregorian)
            calendar.firstWeekday = 2
            return calendar
    }()
        
    private let monthFormatter = DateFormatter()
    private let dateFormatter = DateFormatter()
    private var nowCalendarDate = Date()
    private var dates = [String]()
    
    init() {
        monthFormatter.dateFormat = "yyyy년 MM월"
        monthFormatter.locale = Locale(identifier: "ko_KR")
        dateFormatter.dateFormat = "d"
        dateFormatter.locale = Locale(identifier: "ko_KR")
    }
    
    func getYearMonthText(_ offset: Int) -> String {
//        let yearMonthText = self.monthFormatter.string(from: self.nowCalendarDate)
        guard let targetDate = calendar.date(byAdding: .weekOfYear, value: offset, to: nowCalendarDate),
              let weekInterval = calendar.dateInterval(of: .weekOfYear, for: targetDate) else {
            return ""
        }
        
        var monthText = monthFormatter.string(from: weekInterval.start)
        print("이번 달은요 ", monthText)
        return monthText
    }
    
    func getDateStringsOfWeek(offset: Int) -> [String] {
        guard let targetDate = calendar.date(byAdding: .weekOfYear, value: offset, to: nowCalendarDate),
              let weekInterval = calendar.dateInterval(of: .weekOfYear, for: targetDate) else {
            return []
        }

        var weekDates: [String] = []
        for i in 0..<7 {
            if let date = calendar.date(byAdding: .day, value: i, to: weekInterval.start) {
                weekDates.append(dateFormatter.string(from: date))
            }
        }
        print("이번주는요 ", weekDates)
        return weekDates
    }
    
    func getDayOfWeek(from date: String) -> Int {
        let dayIndex = calendar.component(.weekday, from: nowCalendarDate)
        return (dayIndex + 5) % 7
    }
    
    func getTodayDate() -> String {
        let todayDate = self.dateFormatter.string(from: nowCalendarDate)
        return todayDate
    }
    
    func getTodayDay() -> Int {
        let dayIndex = calendar.component(.weekday, from: nowCalendarDate)
        return (dayIndex + 5) % 7
    }

}
