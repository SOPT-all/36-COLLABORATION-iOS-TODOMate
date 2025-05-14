//
//  HomeView.swift
//  TODOMate
//
//  Created by 성현주 on 5/12/25.
//

import Foundation

final class HomeView: BaseUIView {

    // MARK: - UI Components

    let navigationBar = CustomNavigationBar()

    let categoryButton1 = CapsuleButton().then {
        $0.type = .category
        $0.text = "카테고리 1"
        $0.textColor = .greenCategory1
    }

    let categoryButton2 = CapsuleButton().then {
        $0.type = .toolBar
        $0.text = "루틴등록"
        $0.leftIcon = .reIconRoutinGrey
    }

    let categoryButton3 = CapsuleButton().then {
        $0.type = .ai
        $0.text = "AI 할일생성"
    }

    // MARK: - Custom Methods

    override func setUI() {
        addSubviews(navigationBar, categoryButton1, categoryButton2, categoryButton3)
    }

    override func setLayout() {
        navigationBar.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(48)
        }

        categoryButton1.snp.makeConstraints {
            $0.center.equalToSuperview()
        }

        categoryButton2.snp.makeConstraints {
            $0.top.equalTo(categoryButton1.snp.bottom).offset(20)
            $0.centerX.equalToSuperview()
        }

        categoryButton3.snp.makeConstraints {
            $0.top.equalTo(categoryButton2.snp.bottom).offset(20)
            $0.centerX.equalToSuperview()
        }
    }
}
