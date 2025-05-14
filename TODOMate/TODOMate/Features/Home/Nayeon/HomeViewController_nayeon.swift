//
//  HomeViewController_nayeon.swift
//  TODOMate
//
//  Created by 성현주 on 5/8/25.
//

import UIKit

import SnapKit

final class HomeViewController_nayeon: BaseUIViewController {

    // MARK: - UI Components

    let homeView = HomeView_nayeon()

    // MARK: - Custom Method

    override func setUI() {
        view.addSubviews(homeView)
    }

    override func setLayout() {
        homeView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
