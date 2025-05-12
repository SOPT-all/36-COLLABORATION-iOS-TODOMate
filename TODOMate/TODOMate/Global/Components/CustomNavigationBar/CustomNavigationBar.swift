//
//  CustomNavigationBar.swift
//  TODOMate
//
//  Created by 성현주 on 5/12/25.
//

import UIKit

import SnapKit
import Then

final class CustomNavigationBar: BaseUIView {

    // MARK: - UI Components

    ///실제 아이콘이 추가되면 변경될 예정입니다
    private let logoImageView =  UIImageView().then {
        $0.image = .reIconLogo
    }

    private let calendarButton = UIButton().then {
        $0.setImage(.reIconDatebox, for: .normal)
        $0.tintColor = .black
    }

    private let sendButton = UIButton().then {
        $0.setImage(.reIconDm, for: .normal)
        $0.tintColor = .black
    }

    private let moreButton = UIButton().then {
        $0.setImage(.reIconMenu, for: .normal)
        $0.tintColor = .black
    }

    private let rightStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.spacing = 24
        $0.alignment = .center
    }

    // MARK: - Custom Method

    override func setUI() {
        backgroundColor = .white
        addSubviews(logoImageView, rightStackView)
        [calendarButton, sendButton, moreButton].forEach {
            rightStackView.addArrangedSubview($0)
        }
    }

    override func setLayout() {
        logoImageView.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(19)
            $0.centerY.equalToSuperview()
            $0.width.height.equalTo(30)
        }

        [calendarButton, sendButton, moreButton].forEach {
            $0.snp.makeConstraints {
                $0.width.height.equalTo(24)
            }
        }

        rightStackView.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(16)
            $0.centerY.equalToSuperview()
        }
    }
}
