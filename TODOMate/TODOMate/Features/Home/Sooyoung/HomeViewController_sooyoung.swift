//
//  HomeViewController_sooyoung.swift
//  TODOMate
//
//  Created by 성현주 on 5/8/25.
//

import UIKit

final class HomeViewController_sooyoung: BaseUIViewController {

    // MARK: - UI Components

    let homeView = HomeView_sooyoung()

    // MARK: - Custom Method
    
    var keyboardHeight: CGFloat = 0

    override func setUI() {
        view.addSubviews(homeView)
        view.backgroundColor = .white
        
        homeView.toolbar.detailButton.accessibilityIdentifier = "detailButton"
        homeView.datePicker.accessibilityIdentifier = "datePicker"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupKeyboardObservers()
    }

    override func setLayout() {
        homeView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    override func addTarget() {
        homeView.toolbar.detailButton.addTarget(self, action: #selector(didTapDetailButton), for: .touchUpInside)
        homeView.toolbar.routineButton.addTarget(self, action: #selector(didTapRoutineButton), for: .touchUpInside)
        homeView.toolbar.importantButton.addTarget(self, action: #selector(didTapPriorityButton), for: .touchUpInside)
        homeView.routine.completeButton.addTarget(self, action: #selector(didTapRoutineCompleteButton), for: .touchUpInside)
        homeView.priority.completeButton.addTarget(self, action: #selector(didTapProrityCompleteButton), for: .touchUpInside)
        homeView.datePicker.endRightButton.addTarget(self, action: #selector(didTapEndRightButton), for: .touchUpInside)
        homeView.routine.leftButton.addTarget(self, action: #selector(didTapLeftButton), for: .touchUpInside)
    }
    
    @objc
    override func dismissKeyboard() {
        view.endEditing(true)
        homeView.toolbar.isHidden = true
        homeView.datePicker.isHidden = true
        homeView.routine.isHidden = true
        homeView.priority.isHidden = true
        tabBarController?.tabBar.isHidden = false
    }
    
    @objc
    private func didTapDetailButton() {
        homeView.toolbar.isHidden = false
        homeView.toolbar.detailButton.isSelected = true
        homeView.textField.becomeFirstResponder()
    }
    
    @objc
    private func didTapRoutineButton() {
        homeView.toolbar.routineButton.isSelected = true
        homeView.toolbar.isHidden = false
        homeView.datePicker.isHidden = false
        homeView.routine.isHidden = true
        homeView.priority.isHidden = true
        tabBarController?.tabBar.isHidden = true
        self.hideKeyboardWhenTappedAround()
    }
    
    @objc
    private func didTapPriorityButton() {
        homeView.toolbar.importantButton.isSelected = true
        homeView.toolbar.isHidden = false
        homeView.datePicker.isHidden = true
        homeView.routine.isHidden = true
        homeView.priority.isHidden = false
        tabBarController?.tabBar.isHidden = true
        self.hideKeyboardWhenTappedAround()
    }
    
    @objc
    private func didTapEndRightButton() {
        homeView.datePicker.isHidden = true
        homeView.routine.isHidden = false
    }
    
    @objc
    private func didTapLeftButton() {
        homeView.datePicker.isHidden = false
        homeView.routine.isHidden = true
    }
    
    @objc
    private func didTapRoutineCompleteButton() {
        homeView.routine.isHidden = true
        homeView.textField.becomeFirstResponder()
    }
    
    @objc
    private func didTapProrityCompleteButton() {
        homeView.priority.isHidden = true
        homeView.textField.becomeFirstResponder()
    }
    
    private func setupKeyboardObservers() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShow),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillHide),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
    }

    @objc private func keyboardWillShow(_ notification: Notification) {
        let info = notification.userInfo
            if let keyboardSize = info?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect {
            keyboardHeight = keyboardSize.height
            homeView.toolbar.snp.updateConstraints {
                $0.bottom.equalToSuperview().inset(keyboardHeight)
            }
            homeView.toolbar.isHidden = false
            UIView.animate(withDuration: 0.3) {
                self.view.layoutIfNeeded()
            }
        }
    }

    @objc private func keyboardWillHide(_ notification: Notification) {
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }
}
