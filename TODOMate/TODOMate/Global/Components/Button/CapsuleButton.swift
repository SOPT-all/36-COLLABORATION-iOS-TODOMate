//
//  CapsuleButton.swift
//  TODOMate
//
//  Created by 성현주 on 5/14/25.
//

import UIKit
import SnapKit

final class CapsuleButton: UIButton {

    enum CapsuleButtonType {
        case category
        case ai
        case toolBar
    }

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

    var textColor: UIColor? = .black {
        didSet {
            titleLabelView.textColor = textColor
            leftImageView.tintColor = textColor
            rightImageView.tintColor = textColor
        }
    }

    var leftIcon: UIImage? {
        didSet {
            if type == .toolBar {
                leftImageView.image = leftIcon?
                    .withRenderingMode(.alwaysTemplate)
                    .resize(to: 20)
            }
        }
    }

    override var isSelected: Bool {
        didSet {
            if type == .toolBar {
                updateToolBarStyle()
            }
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

    // MARK: - Setup

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

        case .toolBar:
            titleLabelView.font = .cap_semi_12
            leftImageView.image = leftIcon?.resize(to: 16)
            rightImageView.image = nil
            layoutAI()
            updateToolBarStyle()
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

    private func updateToolBarStyle() {
        if isSelected {
            backgroundColor = .bluegrey40
            titleLabelView.textColor = .white
            leftImageView.tintColor = .white
        } else {
            backgroundColor = .bluegrey10
            titleLabelView.textColor = .bluegrey40
            leftImageView.tintColor = .bluegrey40
        }
    }

}
