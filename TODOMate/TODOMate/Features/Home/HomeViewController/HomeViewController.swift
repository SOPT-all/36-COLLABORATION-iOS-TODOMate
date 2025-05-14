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
        view.addSubview(homeView)
    }

    override func setLayout() {
        homeView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

    override func addTarget() {
        homeView.categoryButton1.addTarget(self, action: #selector(didTapCategoryButton), for: .touchUpInside)
        homeView.categoryButton3.addTarget(self, action: #selector(didTapToolBarButton), for: .touchUpInside)
    }

    @objc
    private func didTapCategoryButton() {
        homeView.todoListView.addMainTask()
    }

    @objc
    private func didTapToolBarButton() {
        homeView.todoListView.addSubTaskToFocused()
    }
}
