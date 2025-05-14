//
//  CapsuleButton.swift
//  TODOMate
//
//  Created by 성현주 on 5/14/25.
//

import UIKit
import SnapKit

final class CapsuleButton: UIButton {

    // MARK: - ButtonType

    enum CapsuleButtonType {
        case category
        case ai
    }

    // MARK: - Public Properties

    var type: CapsuleButtonType = .category {
        didSet {
            configureForType()
        }
    }

    var text: String? {
        didSet {
            titleLabelView.text = text
        }
    }

    var textColor: UIColor?  = .black {
        didSet {
            titleLabelView.textColor = textColor
        }
    }

    // MARK: - UI Components

    private let leftImageView = UIImageView()
    private let titleLabelView = UILabel()
    private let rightImageView = UIImageView()

    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCommonView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - View Setup

    private func setupCommonView() {
        clipsToBounds = true
        layer.cornerRadius = 17

        leftImageView.contentMode = .scaleAspectFit
        rightImageView.contentMode = .scaleAspectFit

        titleLabelView.textAlignment = .center

        addSubviews(leftImageView, titleLabelView, rightImageView)

        self.snp.makeConstraints {
            $0.height.equalTo(35)
        }
    }

    private func configureForType() {
        switch type {
        case .category:
            backgroundColor = .grey10
            titleLabelView.font = .cap_bold_12
            leftImageView.image = .reIconLock.resize(to: 20)
            rightImageView.image = .reIconAdd.resize(to: 24)

            layoutCategory()

        case .ai:
            backgroundColor = .blue10
            titleLabelView.font = .cap_med_12
            leftImageView.image = .reIconAi.resize(to: 24)
            rightImageView.image = nil

            layoutAI()
        }
    }

    // MARK: - Layouts

    private func layoutCategory() {
        leftImageView.isHidden = false
        rightImageView.isHidden = false

        leftImageView.snp.remakeConstraints {
            $0.leading.equalToSuperview().offset(8)
            $0.centerY.equalToSuperview()
        }

        rightImageView.snp.remakeConstraints {
            $0.trailing.equalToSuperview().inset(8)
            $0.centerY.equalToSuperview()
        }

        titleLabelView.snp.remakeConstraints {
            $0.leading.equalTo(leftImageView.snp.trailing).offset(8)
            $0.trailing.equalTo(rightImageView.snp.leading).offset(-8)
            $0.centerY.equalToSuperview()
        }
    }

    private func layoutAI() {
        leftImageView.isHidden = false
        rightImageView.isHidden = true

        leftImageView.snp.remakeConstraints {
            $0.leading.equalToSuperview().offset(8)
            $0.centerY.equalToSuperview()
            $0.size.equalTo(24)
        }

        titleLabelView.snp.remakeConstraints {
            $0.leading.equalTo(leftImageView.snp.trailing).offset(8)
            $0.trailing.equalToSuperview().inset(16)
            $0.centerY.equalToSuperview()
        }

        rightImageView.snp.remakeConstraints {
            $0.size.equalTo(0)
        }
    }
}
