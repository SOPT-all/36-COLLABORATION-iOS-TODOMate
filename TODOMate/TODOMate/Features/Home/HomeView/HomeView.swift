//
//  HomeView.swift
//  TODOMate
//
//  Created by 성현주 on 5/12/25.
//

import UIKit

final class HomeView: BaseUIView {

    // MARK: - UI Components

    let navigationBar = CustomNavigationBar()

    private let scrollView = UIScrollView()
    private let contentView = UIView()

    let categoryButton1 = CapsuleButton().then {
        $0.type = .category
        $0.text = "카테고리 1"
        $0.textColor = .greenCategory1
    }

    let todoListView1 = TodoListView()

    let categoryButton2 = CapsuleButton().then {
        $0.type = .category
        $0.text = "카테고리 2"
        $0.textColor = .redCategory2
    }

    let todoListView2 = TodoListView()

    let categoryButton3 = CapsuleButton().then {
        $0.type = .category
        $0.text = "카테고리 3"
        $0.textColor = .redCategory3
    }

    let todoListView3 = TodoListView()

    let aiButton = CapsuleButton().then {
        $0.type = .ai
        $0.text = "AI 할일생성"
    }

    // MARK: - Custom Methods

    override func setUI() {
        addSubviews(navigationBar, scrollView)
        scrollView.addSubview(contentView)

        contentView.addSubviews(
            categoryButton1, todoListView1,
            categoryButton2, todoListView2,
            categoryButton3, todoListView3,
            aiButton
        )
    }

    override func setLayout() {
        navigationBar.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(48)
        }

        scrollView.snp.makeConstraints {
            $0.top.equalTo(navigationBar.snp.bottom)
            $0.leading.trailing.bottom.equalToSuperview()
        }

        contentView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.width.equalTo(scrollView)
        }

        categoryButton1.snp.makeConstraints {
            $0.top.equalToSuperview().offset(200)
            $0.leading.equalToSuperview().inset(20)
        }

        todoListView1.snp.makeConstraints {
            $0.top.equalTo(categoryButton1.snp.bottom).offset(13)
            $0.leading.trailing.equalToSuperview().inset(20)
        }

        categoryButton2.snp.makeConstraints {
            $0.top.equalTo(todoListView1.snp.bottom).offset(20)
            $0.leading.equalToSuperview().inset(20)
        }

        todoListView2.snp.makeConstraints {
            $0.top.equalTo(categoryButton2.snp.bottom).offset(13)
            $0.leading.trailing.equalToSuperview().inset(20)
        }

        categoryButton3.snp.makeConstraints {
            $0.top.equalTo(todoListView2.snp.bottom).offset(20)
            $0.leading.equalToSuperview().inset(20)
        }

        todoListView3.snp.makeConstraints {
            $0.top.equalTo(categoryButton3.snp.bottom).offset(13)
            $0.leading.trailing.equalToSuperview().inset(20)
        }

        aiButton.snp.makeConstraints {
            $0.top.equalTo(todoListView3.snp.bottom).offset(20)
            $0.leading.equalToSuperview().inset(20)
            $0.bottom.equalToSuperview().inset(80)
        }
    }
}

extension HomeView {
    var todoListViews: [TodoListView] {
        [todoListView1, todoListView2, todoListView3]
    }

    func addSubTaskToFocusedList() {
        todoListViews.forEach { $0.addSubTaskToFocused() }
    }
}
