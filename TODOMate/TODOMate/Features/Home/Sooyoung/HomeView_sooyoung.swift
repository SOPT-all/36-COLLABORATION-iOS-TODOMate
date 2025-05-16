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
    let toolbar = ToolBar()
    let routine = Routine()
    let priority = Priority()

    // MARK: - Custom Methods

    override func setUI() {
        [/*datePicker,*/ toolbar, routine, priority].forEach {
            addSubview($0)
        }
    }
    
    override func setLayout() {
//        datePicker.snp.makeConstraints {
//            $0.top.equalTo(safeAreaLayoutGuide).inset(100)
//            $0.leading.trailing.equalToSuperview()
//            $0.height.greaterThanOrEqualTo(200)
//        }
//        
        toolbar.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.top.equalTo(safeAreaLayoutGuide).offset(50)
        }
        
        routine.snp.makeConstraints {
            $0.top.equalTo(toolbar.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview()
            $0.height.greaterThanOrEqualTo(278)
        }
        
        priority.snp.makeConstraints {
            $0.top.equalTo(routine.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview()
            $0.height.greaterThanOrEqualTo(278)
        }
    }
}
