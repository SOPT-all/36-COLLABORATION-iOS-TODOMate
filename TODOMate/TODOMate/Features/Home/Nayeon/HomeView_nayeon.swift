//
//  HomeView_nayeon.swift
//  TODOMate
//
//  Created by 성현주 on 5/12/25.
//

import Foundation

final class HomeView_nayeon: BaseUIView {

    // MARK: - UI Components

    let navigationBar = CustomNavigationBar()

    // MARK: - Custom Methods

    override func setUI() {
        [navigationBar].forEach {
            addSubview($0)
        }
    }

    override func setLayout() {
        navigationBar.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(48)
        }
    }
}
