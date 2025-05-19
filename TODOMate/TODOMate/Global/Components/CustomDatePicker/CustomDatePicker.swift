//
//  CustomDatePicker.swift
//  TODOMate
//
//  Created by LEESOOYONG on 5/14/25.
//

import UIKit

import SnapKit
import Then

final class CustomDatePicker: BaseUIView {
    
    private let title = UILabel().then {
        $0.text = "시작 날짜"
        $0.textColor = .black
        $0.font = .body_reg_14
        $0.textAlignment = .center
    }
    
    private let startRightButton = UIButton().then {
        $0.setImage(.reIconRoutineNextBlack, for: .normal)
        $0.isHidden = false
    }
    
    let endRightButton = UIButton().then {
        $0.setImage(.reIconRoutineNextBlack, for: .normal)
        $0.isHidden = true
    }
    
    private let leftButton = UIButton().then {
        $0.setImage(.reIconRoutineBeforeBlack, for: .normal)
        $0.isHidden = true
    }

    private let datePicker = UIDatePicker().then {
        $0.datePickerMode = .date
        $0.preferredDatePickerStyle = .wheels
        $0.locale = Locale(identifier: "ko_KR")
    }
    
    private var startDate: Date = Date()
    private var endDate: Date = Date()
    private var isSelectingStartDate: Bool = true
    
    override func setUI() {
        backgroundColor = .white
        [title, leftButton, startRightButton, endRightButton, datePicker].forEach {
            addSubviews($0)
        }
        startRightButton.addTarget(self, action: #selector(didTapRightButton), for: .touchUpInside)
        leftButton.addTarget(self, action: #selector(didTapLeftButton), for: .touchUpInside)
        
        datePicker.setDate(startDate, animated: false)
        datePicker.addTarget(self, action: #selector(dateChanged), for: .valueChanged)
    }
    
    override func setLayout() {
        title.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.top.equalToSuperview().offset(8)
            $0.bottom.equalTo(datePicker.snp.top).offset(-8)
            $0.height.equalTo(30)
        }
        
        startRightButton.snp.makeConstraints {
            $0.centerY.equalTo(title.snp.centerY)
            $0.trailing.equalTo(safeAreaLayoutGuide).inset(24)
            $0.width.height.equalTo(14)
        }
        
        endRightButton.snp.makeConstraints {
            $0.centerY.equalTo(title.snp.centerY)
            $0.trailing.equalTo(safeAreaLayoutGuide).inset(24)
            $0.width.height.equalTo(14)
        }
        
        leftButton.snp.makeConstraints {
            $0.centerY.equalTo(title.snp.centerY)
            $0.leading.equalTo(safeAreaLayoutGuide).inset(24)
            $0.width.height.equalTo(14)
        }
        
        datePicker.snp.makeConstraints {
            $0.top.equalTo(title.snp.bottom).offset(8)
            $0.leading.trailing.equalTo(safeAreaLayoutGuide)
        }
    }
    
    private func addTarget() {
        rightButton.addTarget(self, action: #selector(didTapRightButton), for: .touchUpInside)
        leftButton.addTarget(self, action: #selector(didTapLeftButton), for: .touchUpInside)
        
        datePicker.setDate(startDate, animated: false)
        datePicker.addTarget(self, action: #selector(dateChanged), for: .valueChanged)
    }
    
    @objc private func didTapRightButton() {
        isSelectingStartDate = false
        title.text = "종료 날짜"
        leftButton.isHidden = false
        startRightButton.isHidden = true
        endRightButton.isHidden = false
        datePicker.setDate(endDate, animated: true)
    }
    
    @objc private func didTapLeftButton() {
        isSelectingStartDate = true
        title.text = "시작 날짜"
        leftButton.isHidden = true
        startRightButton.isHidden = false
        endRightButton.isHidden = true
        datePicker.setDate(startDate, animated: true)
    }
    
    @objc private func dateChanged() {
        if isSelectingStartDate {
            startDate = datePicker.date
            if endDate < startDate {
                endDate = startDate
            }
        } else {
            if datePicker.date < startDate {
                endDate = startDate
                datePicker.setDate(startDate, animated: true)
            } else {
                endDate = datePicker.date
            }
        }
    }
}
