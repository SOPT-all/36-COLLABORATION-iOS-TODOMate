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
    var onToggle: ((Int, Bool) -> Void)?

    /// 투두 등록할때 사용하는 콜백입니다
    var onCommit: ((Int, String, TodoView.TaskType, Int?) -> Void)?

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

        let parentID: Int
        if focusedView.taskType == .main {
            parentID = focusedView.id
        } else {
            parentID = todoViews[..<currentIndex].last(where: { $0.taskType == .main })?.id ?? Int()
        }

        let newSubView = makeTodoView(type: .sub, parentID: parentID, shouldFocus: true)
        stackView.insertArrangedSubview(newSubView, at: currentIndex + 1)
        todoViews.insert(newSubView, at: currentIndex + 1)
    }

    // MARK: - Private Methods

    private func makeTodoView(type: TodoView.TaskType, parentID: Int? = nil, shouldFocus: Bool = false) -> TodoView {
        let view = TodoView(taskType: type, shouldFocus: shouldFocus)
        view.parentMainTaskID = parentID

        configureFocusHandler(for: view)
        configureUnfocusHandler(for: view)
        configureToggleHandler(for: view)

        return view
    }

    private func configureFocusHandler(for view: TodoView) {
        view.onFocus = { [weak self] in
            self?.focusedView = view
        }
    }

    private func configureUnfocusHandler(for view: TodoView) {
        view.unFocus = { [weak self] in
            guard let self,
                  let startIndex = todoViews.firstIndex(of: view) else { return }

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
                    if self.stackView.arrangedSubviews.contains($0) {
                        self.stackView.removeArrangedSubview($0)
                        $0.removeFromSuperview()
                    }
                }
                todoViews.removeSubrange(startIndex..<endIndex)
            } else {
                guard !view.hasCommitted else {
                    print("이미 커밋된 뷰입니다: \(view.uuid)")
                    return
                }
                self.onCommit?(view.id, view.text, view.taskType, view.parentMainTaskID)
                view.hasCommitted = true
            }
        }
    }


    private func configureToggleHandler(for view: TodoView) {
        view.onToggle = { [weak self] id, isSelected in
            guard let self else { return }

            self.onToggle?(id, isSelected)

            guard view.taskType == .main,
                  let currentIndex = self.todoViews.firstIndex(of: view) else { return }

            var nextIndex = currentIndex + 1
            while nextIndex < self.todoViews.count,
                  self.todoViews[nextIndex].taskType == .sub {
                let subView = self.todoViews[nextIndex]
                subView.isSelected = isSelected
                self.onToggle?(subView.id, isSelected)
                nextIndex += 1
            }
        }
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
            mainView.hasCommitted = true
            stackView.addArrangedSubview(mainView)
            todoViews.append(mainView)

            for sub in main.subtasks {
                let subView = makeTodoView(type: .sub, parentID: main.id)
                subView.id = sub.id
                subView.text = sub.text
                subView.isSelected = sub.isDone
                subView.hasCommitted = true 
                stackView.addArrangedSubview(subView)
                todoViews.append(subView)
            }
        }
    }

}
