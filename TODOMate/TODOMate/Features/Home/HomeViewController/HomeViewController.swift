//
//  HomeViewController.swift
//  TODOMate
//
//  Created by 성현주 on 5/8/25.
//

import UIKit

final class HomeViewController: BaseUIViewController {

    // MARK: - UI Components

    let homeView = HomeView()

    // MARK: - Custom Method

    override func setUI() {
        view.addSubviews(homeView)
    }

    override func setLayout() {
        homeView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

    override func addTarget() {
        homeView.categoryButton2.addTarget(self, action: #selector(didTapToolBarButton), for: .touchUpInside)
    }

    @objc
    private func didTapToolBarButton() {
        homeView.categoryButton2.isSelected.toggle()
    }
}
