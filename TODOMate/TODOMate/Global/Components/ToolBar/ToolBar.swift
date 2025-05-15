//
//  ToolBar.swift
//  TODOMate
//
//  Created by LEESOOYONG on 5/15/25.
//

import UIKit

import SnapKit
import Then

final class ToolBar: BaseUIView {
    
    private let detailButton = UIButton().then {
        $0.setTitle("세부사항", for: .normal)
        $0.titleLabel?.font = .cap_semi_12
        $0.layer.cornerRadius = 25
        $0.backgroundColor = .bluegrey10
    }
    
    private let routineButton = UIButton().then {
        $0.setTitle("루틴등록", for: .normal)
        $0.titleLabel?.font = .cap_semi_12
        $0.layer.cornerRadius = 25
        $0.backgroundColor = .bluegrey10
    }
    
    private let importantButton = UIButton().then {
        $0.setTitle("중요도", for: .normal)
        $0.titleLabel?.font = .cap_semi_12
        $0.layer.cornerRadius = 25
        $0.backgroundColor = .bluegrey10
    }
    
    private let trashButton = UIButton().then {
        $0.setImage(.reDelete, for: .normal)
    }
    
    private let toolStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.spacing = 8
        $0.alignment = .center
        $0.layer.cornerRadius = 15
        $0.layer.maskedCorners = [
            .layerMinXMinYCorner,
            .layerMaxXMinYCorner
        ]
        $0.clipsToBounds = true
        $0.backgroundColor = .grey10
        $0.distribution = .equalSpacing
        $0.isLayoutMarginsRelativeArrangement = true
        $0.layoutMargins = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
    }
    
    override func setUI() {
        backgroundColor = .white
        addSubviews(toolStackView)
        [detailButton, routineButton, importantButton, trashButton].forEach {
            toolStackView.addArrangedSubview($0)
        }
    }
    
    override func setLayout() {
        detailButton.snp.makeConstraints {
            $0.width.equalTo(92)
            $0.height.equalTo(32)
        }
        
        routineButton.snp.makeConstraints {
            $0.width.equalTo(90)
            $0.height.equalTo(32)
        }
        
        importantButton.snp.makeConstraints {
            $0.width.equalTo(72)
            $0.height.equalTo(32)
        }
        
        trashButton.snp.makeConstraints {
            $0.width.equalTo(42)
            $0.height.equalTo(32)
        }
        
        toolStackView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.centerY.equalToSuperview()
            $0.height.equalTo(50)
        }
    }
}
