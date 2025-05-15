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
        dateFormatter.dateFormat = "dd"
        dateFormatter.locale = Locale(identifier: "ko_KR")
    }
    
    func getYearMonthText() -> String {
        let yearMonthText = self.monthFormatter.string(from: self.nowCalendarDate)
        return yearMonthText
    }
    
    func getDatesOfWeek() -> [Date] {
        guard let weekInterval = calendar.dateInterval(of: .weekOfYear, for: nowCalendarDate) else { return [] }
        
        var weekDates: [Date] = []
        for i in 0..<7 {
            if let date = calendar.date(byAdding: .day, value: i, to: weekInterval.start) {
                weekDates.append(date)
            }
        }
        return weekDates
    }
    
    func getDateStringsOfThisWeek() -> [String] {
        return getDatesOfWeek().map { dateFormatter.string(from: $0) }
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
