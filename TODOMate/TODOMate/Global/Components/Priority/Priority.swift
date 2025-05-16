//
//  Priority.swift
//  TODOMate
//
//  Created by LEESOOYONG on 5/16/25.
//

import UIKit

import SnapKit
import Then

enum PriorityOption: CaseIterable {
    case high, mid, low
    
    var title: String {
        switch self {
        case .high:
            return "상"
        case .mid:
            return "중"
        case .low:
            return "하"
        }
    }
    
    var color: UIImage {
        switch self {
        case .high: return .reIconPriorityHigh
        case .mid: return .reIconPriorityMid
        case .low: return .reIconPriorityLow
        }
    }
}

final class Priority: BaseUIView {
    
    private var selectedOption: PriorityOption?
    
    private let title = UILabel().then {
        $0.text = "중요도"
        $0.textColor = .black
        $0.font = .body_reg_14
        $0.textAlignment = .center
    }
    
    private let completeButton = UIButton().then {
        $0.setTitle("완료", for: .normal)
        $0.setTitleColor(.grey10, for: .normal)
        $0.titleLabel?.font = .cap_reg_12
    }
    
    private lazy var optionStackView = UIStackView().then {
        $0.axis = .vertical
        $0.spacing = 5
        $0.distribution = .fillEqually
    }
    
    private func setupOptions() {
        PriorityOption.allCases.enumerated().forEach { (idx, option) in
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
                $0.contentEdgeInsets = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 0)
                $0.titleEdgeInsets = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 0)
                $0.clipsToBounds = true
                
                if idx == 0 {
                    $0.layer.cornerRadius = 15
                    $0.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
                } else if idx == PriorityOption.allCases.count - 1 {
                    $0.layer.cornerRadius = 15
                    $0.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
                }
            }
            
            let rightImageView = UIImageView().then {
                $0.image = option.color
                $0.contentMode = .scaleAspectFit
            }

            button.addSubview(rightImageView)
            
            rightImageView.snp.makeConstraints {
                $0.centerY.equalToSuperview()
                $0.trailing.equalToSuperview().inset(12)
                $0.width.height.equalTo(14)
            }
            
            optionStackView.addArrangedSubview(button)
        }
    }
    
    override func setUI() {
        [title, completeButton, optionStackView].forEach {
            addSubviews($0)
        }
    }
    
    override func setLayout() {
        title.snp.makeConstraints {
            $0.top.equalToSuperview().offset(16)
            $0.centerX.equalToSuperview()
        }

        completeButton.snp.makeConstraints {
            $0.centerY.equalTo(title)
            $0.trailing.equalToSuperview().inset(16)
        }

        optionStackView.snp.makeConstraints {
            $0.top.equalTo(title.snp.bottom).offset(16)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(140)
        }
        
        setupOptions()
    }
    
    @objc private func optionTapped(_ sender: UIButton) {
        let index = sender.tag
        selectedOption = PriorityOption.allCases[index]

        for (i, view) in optionStackView.arrangedSubviews.enumerated() {
            if let button = view as? UIButton {
                button.isSelected = (i == index)
            }
        }
        completeButton.setTitleColor(.black, for: .normal)
    }

    
    private func optionIndex(_ option: PriorityOption) -> Int {
        return PriorityOption.allCases.firstIndex(of: option) ?? 0
    }
}
