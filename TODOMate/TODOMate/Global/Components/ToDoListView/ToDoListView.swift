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
        $0.spacing = 12
    }

    // MARK: - Properties

    private var todoViews: [TodoView] = []
    private weak var focusedView: TodoView?

    var onToggle: ((UUID, Bool) -> Void)?

    // MARK: - Lifecycle

    override func setUI() {
        addSubview(stackView)
    }

    override func setLayout() {
        stackView.snp.makeConstraints { $0.edges.equalToSuperview() }
    }

    // MARK: - Public Methods

    func addMainTask() {
        let todo = makeTodoView(type: .main)
        stackView.addArrangedSubview(todo)
        todoViews.append(todo)
    }

    func addSubTaskToFocused() {
        guard let focusedView = focusedView else { return }
        guard let currentIndex = todoViews.firstIndex(of: focusedView) else { return }
        let newSubView = makeTodoView(type: .sub)
        stackView.insertArrangedSubview(newSubView, at: currentIndex + 1)
        todoViews.insert(newSubView, at: currentIndex + 1)
    }

    // MARK: - Private Methods

    private func makeTodoView(type: TodoView.TaskType) -> TodoView {
        let view = TodoView(taskType: type)

        view.onFocus = { [weak self] in
            self?.focusedView = view
        }

        view.unFocus = { [weak self] in
            guard let self else { return }
            guard view.isEmpty else { return }
            guard let startIndex = todoViews.firstIndex(of: view) else { return }

            var endIndex = startIndex + 1

            if view.taskType == .main {
                while endIndex < todoViews.count,
                      todoViews[endIndex].taskType == .sub {
                    endIndex += 1
                }
            }

            let viewsToRemove = todoViews[startIndex..<endIndex]
            viewsToRemove.reversed().forEach {
                self.stackView.removeArrangedSubview($0)
                $0.removeFromSuperview()
            }
            todoViews.removeSubrange(startIndex..<endIndex)
        }


        view.onToggle = { [weak self] id, isSelected in
            self?.onToggle?(id, isSelected)
        }

        return view
    }

}
