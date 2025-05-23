//
//  WeekBox.swift
//  TODOMate
//
//  Created by 이나연 on 5/15/25.
//

import UIKit

import SnapKit
import Then

protocol WeekBoxMoveButtonDelegate: AnyObject {
    func didTapPreMoveButton()
    func didTapRightMoveButton()
}

final class WeekBox: BaseUIView {
    
    // MARK: - Properties
    weak var delegate: WeekBoxMoveButtonDelegate?
    
    private let formatter = CalendarDateFormatter()
    private var monthOffset: Int = 0
    
    // MARK: - UI Components
    private lazy var monthLabel = UILabel().then {
        $0.font = .cap_bold_12
        $0.textColor = .black
        $0.text = formatter.getYearMonthText(monthOffset)
    }
    
    private let checkBoxIcon = WeekBoxIconImage(img: .reIconCheck)
    private let checkLabel = WeekBoxLabel(textColor: .darkgrey30)
    
    private let smileIcon = WeekBoxIconImage(img: .reIconSmile)
    private let smileCount = WeekBoxLabel()
    
    private let heartIcon = WeekBoxIconImage(img: .reIconHeart)
    private let heartCount = WeekBoxLabel()
    
    private lazy var leftMoveIcon = UIButton().then {
        $0.setBackgroundImage(.reIconMoveLeft, for: .normal)
        $0.contentMode = .scaleAspectFill
    }
    
    private lazy var rightMoveIcon = UIButton().then {
        $0.setBackgroundImage(.reIconMoveRight, for: .normal)
        $0.contentMode = .scaleAspectFill
    }
    
    private let changeWeekToMonthButton = UIButton().then {
        $0.setTitle("주", for: .normal)
        $0.backgroundColor = .grey10
        $0.titleLabel?.font = .cap_bold_12
        $0.setTitleColor(.darkgrey10, for: .normal)
        $0.layer.cornerRadius = 13
    }
    
    // MARK: - SetUp Method
    
    override func setUI() {
        addSubviews(monthLabel, checkBoxIcon, checkLabel, smileIcon, smileCount, heartIcon, heartCount, leftMoveIcon, rightMoveIcon, changeWeekToMonthButton)
        addTarget()
    }
    
    override func setLayout() {
        monthLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview()
        }
        
        checkBoxIcon.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(monthLabel.snp.trailing).offset(8)
            $0.width.height.equalTo(12)
        }
        
        checkLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(checkBoxIcon.snp.trailing).offset(4)
        }
        
        smileIcon.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(checkLabel.snp.trailing).offset(7)
            $0.width.height.equalTo(12)
        }
        
        smileCount.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(smileIcon.snp.trailing).offset(3)
        }
        
        heartIcon.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(smileCount.snp.trailing).offset(8)
            $0.width.height.equalTo(12)
        }
        
        heartCount.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(heartIcon.snp.trailing).offset(4)
        }
        
        leftMoveIcon.snp.makeConstraints {
            $0.width.height.equalTo(12)
            $0.centerY.equalToSuperview()
            $0.trailing.equalTo(rightMoveIcon.snp.leading).offset(-24)
        }
        
        rightMoveIcon.snp.makeConstraints {
            $0.width.height.equalTo(12)
            $0.centerY.equalToSuperview()
            $0.trailing.equalTo(changeWeekToMonthButton.snp.leading).offset(-20)
        }
        
        changeWeekToMonthButton.snp.makeConstraints {
            $0.width.equalTo(34)
            $0.height.equalTo(25)
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview()
        }
    }
    
    private func addTarget() {
        leftMoveIcon.addTarget(self, action: #selector(didTapLeftIcon), for: .touchUpInside)
        rightMoveIcon.addTarget(self, action: #selector(didTapRightIcon), for: .touchUpInside)
    }
    
    // MARK: - Actions
    
    @objc
    private func didTapLeftIcon() {
        delegate?.didTapPreMoveButton()
        monthOffset -= 1
        monthLabel.text = formatter.getYearMonthText(monthOffset)
    }
    
    @objc
    private func didTapRightIcon() {
        delegate?.didTapRightMoveButton()
        monthOffset += 1
        monthLabel.text = formatter.getYearMonthText(monthOffset)
    }
}
