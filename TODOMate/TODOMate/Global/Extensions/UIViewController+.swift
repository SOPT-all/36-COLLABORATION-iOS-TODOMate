//
//  UIViewController+.swift
//  TODOMate
//
//  Created by 성현주 on 5/14/25.
//

import UIKit

extension UIViewController: UIGestureRecognizerDelegate {

    /// 키보드 위 화면 터치 시, 키보드 내리기
    func hideKeyboardWhenTappedAround() {
        let tapped = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tapped.delegate = self
        tapped.cancelsTouchesInView = false
        view.addGestureRecognizer(tapped)
    }

    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
            if let view = touch.view {
                // 버튼이며, 식별자가 detailButton이면 제스처 무시
                if view is UIButton, view.accessibilityIdentifier == "detailButton" {
                    return false
                }
            }
            return true
        }
}

