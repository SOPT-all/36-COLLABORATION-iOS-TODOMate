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
    
    // 키보드 테스트용 텍스트필드
    private let textField = UITextField().then {
        $0.placeholder = "테스트용 텍스트필드"
        $0.autocorrectionType = .no
        $0.spellCheckingType = .no
    }

    override func setUI() {
        [/*datePicker,*/ toolbar, routine, priority, textField].forEach {
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
        textField.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(safeAreaLayoutGuide)
            $0.height.equalTo(50)
        }
        
//        toolbar.snp.makeConstraints {
//            $0.leading.trailing.equalToSuperview()
//            $0.bottom.equalTo(keyboardLayoutGuide.snp.top)
//        }
//        
//        routine.snp.makeConstraints {
//            $0.top.equalTo(toolbar.snp.bottom).offset(20)
//            $0.leading.trailing.equalToSuperview()
//            $0.height.greaterThanOrEqualTo(278)
//        }
//        
//        priority.snp.makeConstraints {
//            $0.top.equalTo(routine.snp.bottom).offset(20)
//            $0.leading.trailing.equalToSuperview()
//            $0.height.greaterThanOrEqualTo(278)
//        }
    }
}
