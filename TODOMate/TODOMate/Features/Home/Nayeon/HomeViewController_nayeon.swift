//
//  HomeViewController_nayeon.swift
//  TODOMate
//
//  Created by 성현주 on 5/8/25.
//

import UIKit

final class HomeViewController_nayeon: BaseUIViewController {

    // MARK: - UI Components

    let homeView = HomeView_nayeon()

    // MARK: - Custom Method

    override func setUI() {
        view.addSubviews(homeView)
        view.backgroundColor = .red
    }

    override func setLayout() {
        homeView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
