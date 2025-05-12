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

    private let closeButton = UIButton().then {
        $0.setImage(UIImage(systemName: "xmark.circle.fill"), for: .normal)
        $0.tintColor = .black
        $0.backgroundColor = UIColor(white: 0.95, alpha: 1)
        $0.layer.cornerRadius = 16
        $0.clipsToBounds = true
    }

    private let calendarButton = UIButton().then {
        $0.setImage(UIImage(systemName: "calendar"), for: .normal)
        $0.tintColor = .black
    }

    private let sendButton = UIButton().then {
        $0.setImage(UIImage(systemName: "paperplane"), for: .normal)
        $0.tintColor = .black
    }

    private let moreButton = UIButton().then {
        $0.setImage(UIImage(systemName: "ellipsis.circle"), for: .normal)
        $0.tintColor = .black
    }

    private lazy var rightStackView = UIStackView(arrangedSubviews: [calendarButton, sendButton, moreButton]).then {
        $0.axis = .horizontal
        $0.spacing = 16
        $0.alignment = .center
    }

    // MARK: - Custom Method

    override func setUI() {
        backgroundColor = .white
        addSubview(closeButton)
        addSubview(rightStackView)
    }

    override func setLayout() {
        closeButton.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(16)
            $0.centerY.equalToSuperview()
            $0.width.height.equalTo(32)
        }

        rightStackView.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(16)
            $0.centerY.equalToSuperview()
        }
    }
}
