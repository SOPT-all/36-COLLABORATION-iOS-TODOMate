//
//  ToDoListView.swift
//  TODOMate
//
//  Created by 성현주 on 5/15/25.
//

import UIKit

final class TodoListView: BaseUIView {

    // MARK: - UI

    private let stackView = UIStackView().then {
        $0.axis = .vertical
        $0.spacing = 8
    }

    // MARK: - Properties

    private var todoViews: [TodoView] = []
    private weak var focusedView: TodoView?

    /// 투두 완료했을때 사용하는 콜백입니다
    var onToggle: ((UUID, Bool) -> Void)?

    /// 투두 등록할때 사용하는 콜백입니다
    var onCommit: ((UUID, String, TodoView.TaskType, UUID?) -> Void)?

    // MARK: - Lifecycle

    override func setUI() {
        addSubview(stackView)
    }

    override func setLayout() {
        stackView.snp.makeConstraints { $0.edges.equalToSuperview() }
    }

    // MARK: - Public Methods

    func addMainTask() {
        let todo = makeTodoView(type: .main, shouldFocus: true)
        stackView.addArrangedSubview(todo)
        todoViews.append(todo)
    }

    func addSubTaskToFocused() {
        guard let focusedView = focusedView else { return }
        guard let currentIndex = todoViews.firstIndex(of: focusedView) else { return }

        let parentID: UUID
        if focusedView.taskType == .main {
            parentID = focusedView.id
        } else {
            parentID = todoViews[..<currentIndex].last(where: { $0.taskType == .main })?.id ?? UUID()
        }

        let newSubView = makeTodoView(type: .sub, parentID: parentID, shouldFocus: true)
        stackView.insertArrangedSubview(newSubView, at: currentIndex + 1)
        todoViews.insert(newSubView, at: currentIndex + 1)
    }

    // MARK: - Private Methods

    private func makeTodoView(type: TodoView.TaskType, parentID: UUID? = nil, shouldFocus: Bool = false) -> TodoView {
        let view = TodoView(taskType: type, shouldFocus: shouldFocus)
        view.parentMainTaskID = parentID

        view.onFocus = { [weak self] in
            self?.focusedView = view
        }

        view.unFocus = { [weak self] in
            guard let self else { return }
            guard let startIndex = todoViews.firstIndex(of: view) else { return }

            if view.isEmpty {
                var endIndex = startIndex + 1

                if view.taskType == .main {
                    while endIndex < todoViews.count,
                          todoViews[endIndex].taskType == .sub {
                        endIndex += 1
                    }
                }

                let viewsToRemove = todoViews[startIndex..<endIndex]
                viewsToRemove.forEach {
                    self.stackView.removeArrangedSubview($0)
                    $0.removeFromSuperview()
                }
                todoViews.removeSubrange(startIndex..<endIndex)
            } else {
                self.onCommit?(view.id, view.text, view.taskType, view.parentMainTaskID)
            }
        }

        view.onToggle = { [weak self] id, isSelected in
            self?.onToggle?(id, isSelected)
        }

        return view
    }
}

/// 처음에 뷰를 그릴때 사용합니다. 로직 조금만더 고민하고, 위로 올릴게용 ㅠ
extension TodoListView {
    func configure(with mainTasks: [MainTask]) {
        stackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        todoViews.removeAll()

        for main in mainTasks {
            let mainView = makeTodoView(type: .main)
            mainView.id = main.id
            mainView.text = main.text
            mainView.isSelected = main.isDone
            stackView.addArrangedSubview(mainView)
            todoViews.append(mainView)

            for sub in main.subtasks {
                let subView = makeTodoView(type: .sub, parentID: main.id)
                subView.id = sub.id
                subView.text = sub.text
                subView.isSelected = sub.isDone
                stackView.addArrangedSubview(subView)
                todoViews.append(subView)
            }
        }
    }
}
