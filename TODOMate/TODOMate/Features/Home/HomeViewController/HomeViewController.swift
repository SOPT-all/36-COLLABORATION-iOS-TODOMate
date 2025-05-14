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

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configureMockTodos()
    }

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
        setCallBacks()
        homeView.categoryButton1.addTarget(self, action: #selector(didTapCategory1Button), for: .touchUpInside)
        homeView.categoryButton2.addTarget(self, action: #selector(didTapCategory2Button), for: .touchUpInside)
        homeView.categoryButton3.addTarget(self, action: #selector(didTapCategory3Button), for: .touchUpInside)
        homeView.aiButton.addTarget(self, action: #selector(didTapToolBarButton), for: .touchUpInside)
    }

    // MARK: - Private Methods

    private func setCallBacks() {
        setupTodoToggleCallbacks()
        setupTodoCommitCallbacks()
    }

    /// 투두 완료 api 호출을 위한 함수입니당 제발 request 안바뀌길,,,,
    private func setupTodoToggleCallbacks() {
        homeView.todoListViews.enumerated().forEach { index, listView in
            listView.onToggle = { id, isSelected in
                print("[카테고리\(index + 1)] ID: \(id), 상태: \(isSelected)")
            }
        }
    }

    /// 투두 등록 api 호출을 위한 함수입니다.
    private func setupTodoCommitCallbacks() {
        homeView.todoListViews.enumerated().forEach { index, listView in
            listView.onCommit = { id, text, type, parentID in
                if type == .main {
                    print("[카테고리\(index + 1)] 투두 생성됨yo → ID: \(id), 내용: \(text), 넌 어떤 타입이니?: \(type)")
                } else {
                    print("[카테고리\(index + 1)] 투두 생성됨yo → ID: \(id), 내용: \(text), 넌 어떤 타입이니?: \(type), 서브구나 너 메인 아이디는 뭐냐고요: \(String(describing: parentID))")
                }
            }

        }
    }

    ///목데이터 테스트입니다
    private func configureMockTodos() {
        let mock = ToDoModel.mockData()
        if let category1 = mock.first(where: { $0.categoryID == 1 }) {
            homeView.todoListView1.configure(with: category1.mainTasks)
        }
        if let category2 = mock.first(where: { $0.categoryID == 2 }) {
            homeView.todoListView2.configure(with: category2.mainTasks)
        }
        if let category3 = mock.first(where: { $0.categoryID == 3 }) {
            homeView.todoListView3.configure(with: category3.mainTasks)
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
