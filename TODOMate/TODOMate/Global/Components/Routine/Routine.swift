//
//  Priority_Routine.swift
//  TODOMate
//
//  Created by LEESOOYONG on 5/15/25.
//

import UIKit

import SnapKit
import Then

enum RepeatOption: CaseIterable {
    case daily, weekly, biweekly, monthly, yearly
    
    var title: String {
        switch self {
        case .daily:
            return "매일"
        case .weekly:
            return "매주"
        case .biweekly:
            return "격주"
        case .monthly:
            return "매월"
        case .yearly:
            return "매년"
        }
    }
}

final class Routine: BaseUIView {
    
    private var selectedOption: RepeatOption?
    
    private let title = UILabel().then {
        $0.text = "반복"
        $0.textColor = .black
        $0.font = .body_reg_14
        $0.textAlignment = .center
    }
    
    private let leftButton = UIButton().then {
        $0.setImage(.reIconRoutineBeforeBlack, for: .normal)
    }
    
    private let completeButton = UIButton().then {
        $0.setTitle("완료", for: .normal)
        $0.setTitleColor(.grey10, for: .normal)
    }
    
    private lazy var optionStackView = UIStackView().then {
        $0.axis = .vertical
        $0.spacing = 5
    }
    
    private func setupOptions() {
        RepeatOption.allCases.forEach { option in
            let button = UIButton().then {
                $0.setTitle(option.title, for: .normal)
                $0.titleLabel?.font = .cap_reg_12
                $0.setTitleColor(.black, for: .normal)
                $0.contentHorizontalAlignment = .left
                $0.setImage(.reIconSelectionDeactivated, for: .normal)
                $0.setImage(.reIconSelectionActivated, for: .selected)
                $0.addTarget(self, action: #selector(optionTapped(_:)), for: .touchUpInside)
                $0.tag = optionIndex(option)
                $0.backgroundColor = .grey20
            }
            optionStackView.addArrangedSubview(button)
        }
    }
    
    override func setUI() {
        [title, leftButton, completeButton, optionStackView].forEach {
            addSubviews($0)
        }
    }
    
    override func setLayout() {
        title.snp.makeConstraints {
            $0.top.equalToSuperview().offset(16)
            $0.centerX.equalToSuperview()
        }

        leftButton.snp.makeConstraints {
            $0.centerY.equalTo(title)
            $0.leading.equalToSuperview().offset(16)
            $0.size.equalTo(24)
        }

        completeButton.snp.makeConstraints {
            $0.centerY.equalTo(title)
            $0.trailing.equalToSuperview().inset(16)
        }

        optionStackView.snp.makeConstraints {
            $0.top.equalTo(title.snp.bottom).offset(16)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(250)
        }
    }
    
    @objc private func optionTapped(_ sender: UIButton) {
        let index = sender.tag
        selectedOption = RepeatOption.allCases[index]

        for (i, view) in optionStackView.arrangedSubviews.enumerated() {
            if let button = view as? UIButton {
                button.isSelected = (i == index)
            }
        }
        completeButton.setTitleColor(.black, for: .normal)
    }
    
    private func optionIndex(_ option: RepeatOption) -> Int {
        return RepeatOption.allCases.firstIndex(of: option) ?? 0
    }
}

