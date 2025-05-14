//
//  WeekBoxLabel.swift
//  TODOMate
//
//  Created by 이나연 on 5/15/25.
//

import UIKit

final class WeekBoxLabel: UILabel {
    init(count: Int = 0, textColor: UIColor = .grey70) {
        super.init(frame: .zero)
        self.font = .cap_bold_12
        self.text = "\(count)"
        self.textColor = textColor
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
