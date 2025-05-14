//
//  CalenderView.swift
//  TODOMate
//
//  Created by 이나연 on 5/15/25.
//

import UIKit

import SnapKit
import Then

final class CalenderView: BaseUIView {
    
    // MARK: - UI Components
    
    private let weekBox = WeekBox()
    
    // MARK: - SetUp Method
    
    override func setUI() {
        addSubviews(weekBox)
    }
    
    override func setLayout() {
        weekBox.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(24)
        }
    }
}
