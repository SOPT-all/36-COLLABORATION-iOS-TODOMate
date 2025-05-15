//
//  CalendarDayLabel.swift
//  TODOMate
//
//  Created by 이나연 on 5/15/25.
//

import UIKit

final class CalendarDayLabel: UILabel {
    init(weekday: String = "weekday") {
        super.init(frame: .zero)
        self.font = .cap_medi_10
        self.textAlignment = .center
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
