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
    let textField = UITextField().then {
        $0.placeholder = "테스트용 텍스트필드"
        $0.autocorrectionType = .no
        $0.spellCheckingType = .no
    }

    override func setUI() {
        [datePicker, toolbar, routine, priority, textField].forEach {
            addSubview($0)
        }
        
        datePicker.tag = 1001
        routine.tag = 1002
        priority.tag = 1003
        
        datePicker.isHidden = true
        routine.isHidden = true
        priority.isHidden = true
    }
    
    override func setLayout() {
        datePicker.snp.makeConstraints {
            $0.top.equalTo(toolbar.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(safeAreaLayoutGuide)
            $0.height.equalTo(278)
        }

        textField.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(safeAreaLayoutGuide)
            $0.height.equalTo(50)
        }
        
        toolbar.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
            $0.height.equalTo(50)
        }
        
        routine.snp.makeConstraints {
            $0.top.equalTo(toolbar.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(278)
        }
        
        priority.snp.makeConstraints {
            $0.top.equalTo(toolbar.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(safeAreaLayoutGuide)
            $0.height.equalTo(278)
        }
    }
}
