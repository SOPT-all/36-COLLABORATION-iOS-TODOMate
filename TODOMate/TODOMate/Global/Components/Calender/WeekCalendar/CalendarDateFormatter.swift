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
    
    // MARK: - Properties
        
    private let calendarFormatter = DateFormatter()
    private let monthFormatter = DateFormatter()
    private let dateFormatter = DateFormatter()
    private var nowCalendarDate = Date()
    private var dates = [String]()
    private var weekDates: [String] = []
    
    init() {
        calendarFormatter.dateFormat = "yyMMdd"
        monthFormatter.dateFormat = "yyyy년 MM월"
        monthFormatter.locale = Locale(identifier: "ko_KR")
        dateFormatter.dateFormat = "d"
        dateFormatter.locale = Locale(identifier: "ko_KR")
    }
    
    func getYearMonthText(_ offset: Int) -> String {
        guard let targetDate = calendar.date(byAdding: .weekOfYear, value: offset, to: nowCalendarDate),
              let weekInterval = calendar.dateInterval(of: .weekOfYear, for: targetDate) else {
            return ""
        }
        
        let monthText = monthFormatter.string(from: weekInterval.start)
        print("이번 달은요 ", monthText)
        return monthText
    }
    
    func getWeekDateStringsOfWeek(_ offset: Int) -> [String] {
        guard let targetDate = calendar.date(byAdding: .weekOfYear, value: offset, to: nowCalendarDate),
              let weekInterval = calendar.dateInterval(of: .weekOfYear, for: targetDate) else {
            return []
        }

        for i in 0..<7 {
            if let date = calendar.date(byAdding: .day, value: i, to: weekInterval.start) {
                weekDates.append(calendarFormatter.string(from: date))
            }
        }
        print("이번주는요 ", weekDates)
        return weekDates
    }
    
    func getDateStringOfWeek(_ offset: Int) -> [String] {
        let dateStrings = getWeekDateStringsOfWeek(offset)
        return dateStrings.map { String($0.suffix(2)) }
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
