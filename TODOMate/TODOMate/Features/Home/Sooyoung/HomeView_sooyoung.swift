//
//  HomeView_sooyoung.swift
//  TODOMate
//
//  Created by 성현주 on 5/12/25.
//

import UIKit
import Foundation
import Then

final class HomeView_sooyoung: BaseUIView {

    // MARK: - UI Components

    let datePicker = CustomDatePicker()

    // MARK: - Custom Methods

    override func setUI() {
        [datePicker].forEach {
            addSubview($0)
        }
    }
    
    override func setLayout() {
        datePicker.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide).inset(100)
            $0.leading.trailing.equalToSuperview()
            $0.height.greaterThanOrEqualTo(200)
        }
    }
}
