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

    override func setUI() {
        view.addSubviews(homeView)
        view.backgroundColor = .white
    }

    override func setLayout() {
        homeView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        homeView.toolbar.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(view.keyboardLayoutGuide.snp.top)
            $0.height.equalTo(50)
        }
    }
    
    override func addTarget() {
        homeView.toolbar.detailButton.addTarget(self, action: #selector(didTapDetailButton), for: .touchUpInside)
        homeView.toolbar.routineButton.addTarget(self, action: #selector(didTapRoutineButton), for: .touchUpInside)
        homeView.toolbar.importantButton.addTarget(self, action: #selector(didTapPriorityButton), for: .touchUpInside)
    }
    
    @objc
    private func didTapDetailButton() {
        homeView.toolbar.detailButton.isSelected.toggle()
    }
    
    @objc
    private func didTapRoutineButton() {
        homeView.toolbar.routineButton.isSelected.toggle()
    }
    
    @objc
    private func didTapPriorityButton() {
        homeView.toolbar.importantButton.isSelected.toggle()
    }
}
