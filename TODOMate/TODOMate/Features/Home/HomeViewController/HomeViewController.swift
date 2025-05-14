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
        setupTodoToggleCallbacks()
        homeView.categoryButton1.addTarget(self, action: #selector(didTapCategory1Button), for: .touchUpInside)
        homeView.categoryButton2.addTarget(self, action: #selector(didTapCategory2Button), for: .touchUpInside)
        homeView.categoryButton3.addTarget(self, action: #selector(didTapCategory3Button), for: .touchUpInside)
        homeView.aiButton.addTarget(self, action: #selector(didTapToolBarButton), for: .touchUpInside)
    }

    // MARK: - Private Methods

    private func setupTodoToggleCallbacks() {
        homeView.todoListViews.enumerated().forEach { index, listView in
            listView.onToggle = { id, isSelected in
                print("[카테고리\(index + 1)] Todo ID: \(id), 상태: \(isSelected)")
            }
        }
    }

    // MARK: - Action Methods

    @objc
    private func didTapCategory1Button() {
        homeView.todoListView1.addMainTask()
    }

    @objc
    private func didTapCategory2Button() {
        homeView.todoListView2.addMainTask()
    }

    @objc
    private func didTapCategory3Button() {
        homeView.todoListView3.addMainTask()
    }

    @objc
    private func didTapToolBarButton() {
        homeView.addSubTaskToFocusedList()
    }
}
