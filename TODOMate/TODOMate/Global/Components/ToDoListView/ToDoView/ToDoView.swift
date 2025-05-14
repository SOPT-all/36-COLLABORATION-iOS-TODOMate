//
//  ToDoView.swift
//  TODOMate
//
//  Created by 성현주 on 5/14/25.
//

import UIKit

import SnapKit

final class TodoView: BaseUIView {

    // MARK: - Type

    enum TaskType {
        case main
        case sub
    }

    // MARK: - Properties

    ///추후 int값으로 들어오는 id로 바꿀 예정입니다.
    public let id: UUID = UUID()

    public var onToggle: ((UUID, Bool) -> Void)?
    public var onFocus: (() -> Void)?
    public var unFocus: (() -> Void)?

    public var isSelected: Bool = false {
        didSet {
            updateImageForSelection()
        }
    }

    public var isEmpty: Bool {
        return textView.text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }

    private let taskType: TaskType

    // MARK: - UI Components

    private let imageButton = UIButton().then {
        $0.contentMode = .scaleAspectFit
    }

    private let textView = UITextView().then {
        $0.textColor = .black
        $0.backgroundColor = .clear
        $0.isScrollEnabled = false
        $0.textContainerInset = .zero
        $0.textContainer.lineFragmentPadding = 0
    }

    private let underlineView = UIView().then {
        $0.backgroundColor = .greenCategory1
        $0.isHidden = true
    }

    // MARK: - Init

    init(taskType: TaskType) {
        self.taskType = taskType
        super.init(frame: .zero)
        self.textView.delegate = self
        self.textView.becomeFirstResponder()
        self.underlineView.isHidden = false
        updateImageForSelection()
        configureTap()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Custom Methods

    override func setUI() {
        backgroundColor = .clear
        addSubviews(imageButton, textView, underlineView)
        textView.font = (taskType == .main) ? .body_reg_14 : .cap_reg_12
    }

    override func setLayout() {
        let iconSize: CGFloat = (taskType == .main) ? 20 : 16
        let topBottomPadding: CGFloat = (taskType == .main) ? 8 : 4
        let leadingInset: CGFloat = (taskType == .main) ? 0 : 24

        imageButton.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(leadingInset)
            $0.centerY.equalToSuperview()
            $0.size.equalTo(iconSize)
        }

        textView.snp.makeConstraints {
            $0.leading.equalTo(imageButton.snp.trailing).offset(10)
            $0.trailing.equalToSuperview().inset(16)
            $0.top.equalToSuperview().offset(topBottomPadding)
            $0.bottom.equalToSuperview().inset(topBottomPadding)
        }

        underlineView.snp.makeConstraints {
            if taskType == .main {
                $0.leading.equalTo(textView.snp.leading)
                $0.trailing.equalTo(textView.snp.trailing)
            } else {
                $0.leading.equalToSuperview().offset(leadingInset)
                $0.trailing.equalToSuperview()
            }
            $0.top.equalTo(textView.snp.bottom).offset(4)
            $0.height.equalTo(1.5)
        }
    }

    private func configureTap() {
        imageButton.addTarget(self, action: #selector(didTapImageButton), for: .touchUpInside)
    }

    private func updateImageForSelection() {
        let image: UIImage = isSelected ? .reIconCheck : .reIconWeekdayUnchecked
        imageButton.setImage(image, for: .normal)
    }

    @objc
    private func didTapImageButton() {
        isSelected.toggle()
        onToggle?(id, isSelected)
    }
}

// MARK: - UITextViewDelegate

extension TodoView: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        underlineView.isHidden = false
        onFocus?()
    }

    func textViewDidEndEditing(_ textView: UITextView) {
        underlineView.isHidden = true
        unFocus?()
    }
}
