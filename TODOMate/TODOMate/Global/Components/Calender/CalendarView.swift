//
//  CalenderView.swift
//  TODOMate
//
//  Created by 이나연 on 5/15/25.
//

import UIKit

import SnapKit
import Then

final class CalendarView: BaseUIView {
    
    // MARK: - UI Components
    
    private let weekBox = WeekBox()
    public let weekCalendar = WeekCalendar()
    
    // MARK: - SetUp Method
    
    override func setUI() {
        addSubviews(weekBox, weekCalendar)
        setDelegate()
    }
    
    override func setLayout() {
        weekBox.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(24)
            $0.height.equalTo(25)
        }
        
        weekCalendar.snp.makeConstraints {
            $0.top.equalTo(weekBox.snp.bottom)
            $0.leading.trailing.equalToSuperview().inset(24)
            $0.height.equalTo(65)
        }
    }
    
    private func setDelegate() {
        weekBox.delegate = weekCalendar
    }
}
