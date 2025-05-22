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
    var keyboardHeight: CGFloat = 0

    // MARK: - Singletone
    
    private let detailTasksService: DetailTasksService = DetailTasksService()
    private let subTaskPatchService: SubTaskPatchService = SubTaskPatchService()
    private let addTaskService: AddTaskService = AddTaskService()
    private let patchMainService: MainCompletedService = MainCompletedService()
    
    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupKeyboardObservers()
        getDetailTodoList()
    }

    // MARK: - Custom Method

    override func setUI() {
        view.addSubview(homeView)
        
        homeView.toolbar.detailButton.accessibilityIdentifier = "detailButton"
        homeView.datePicker.accessibilityIdentifier = "datePicker"
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
        homeView.toolbar.detailButton.addTarget(self, action: #selector(didTapDetailButton), for: .touchUpInside)
        homeView.toolbar.routineButton.addTarget(self, action: #selector(didTapRoutineButton), for: .touchUpInside)
        homeView.toolbar.importantButton.addTarget(self, action: #selector(didTapPriorityButton), for: .touchUpInside)
        homeView.routine.completeButton.addTarget(self, action: #selector(didTapRoutineCompleteButton), for: .touchUpInside)
        homeView.priority.completeButton.addTarget(self, action: #selector(didTapProrityCompleteButton), for: .touchUpInside)
        homeView.datePicker.endRightButton.addTarget(self, action: #selector(didTapEndRightButton), for: .touchUpInside)
        homeView.routine.leftButton.addTarget(self, action: #selector(didTapLeftButton), for: .touchUpInside)
    }

    override func setDelegate() {
        homeView.calenderView.weekCalendar.delegate = self
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
                
                let subRequest = SubTaskPatchRequest(completed: isSelected)
                let mainRequest = MainCompletedRequest(completed: isSelected)
                
                Task {
                    do {
                            let mainResult = try await self.patchMainService.patchMainTask(id: id, request: mainRequest)
//                        let subResult = try await self.subTaskPatchService.patchSubTask(id: id, request: subRequest)
                        print("메인테스크 상태 패치 완료", mainResult)
//                        print("서브태스크 상태 패치 완료", subResult)
                    } catch {
                        print("패치 에러: \(error)")
                    }
                }
            }
        }
    }

    /// 투두 등록 api 호출을 위한 함수입니다.
    private func setupTodoCommitCallbacks() {
        homeView.todoListViews.enumerated().forEach { index, listView in
            listView.onCommit = { id, text, type, parentID in
                if type == .main {
                    print("[카테고리\(index + 1)] 투두 생성됨yo → ID: \(id), 내용: \(text), 넌 어떤 타입이니?: \(type)")
                    self.addMainTask(text: text, categoryIndex: index + 1)
                } else {
                    guard let parentID = parentID else {
                        print("parentID가 nill입니다")
                        return
                    }
                    print("[카테고리\(index + 1)] 서브투두 생성됨yo → ID: \(id), 내용: \(text), 넌 어떤 타입이니?: \(type), 서브구나 너 메인 아이디는 뭐냐고요: \(String(describing: parentID))")
                    self.addSubTask(text: text, mainTaskId: parentID)
                }
            }
        }
    }

    private func setupKeyboardObservers() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShow),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
//        NotificationCenter.default.addObserver(
//            self,
//            selector: #selector(keyboardWillHide),
//            name: UIResponder.keyboardWillHideNotification,
//            object: nil
//        )
    }
    
    // api 호출 시 선택된 날짜를 가져오는 함수입니다
    private func getSelectedDate() -> String {
        return homeView.calenderView.weekCalendar.selectedDate
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
    private func keyboardWillShow(_ notification: Notification) {
        let info = notification.userInfo
            if let keyboardSize = info?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect {
            keyboardHeight = keyboardSize.height
            homeView.toolbar.snp.updateConstraints {
                $0.bottom.equalToSuperview().inset(keyboardHeight)
            }
            homeView.toolbar.isHidden = false
            UIView.animate(withDuration: 0.3) {
                self.view.layoutIfNeeded()
            }
        }
    }
    
    @objc
    override func dismissKeyboard() {
        view.endEditing(true)
        homeView.toolbar.isHidden = true
        homeView.datePicker.isHidden = true
        homeView.routine.isHidden = true
        homeView.priority.isHidden = true
        tabBarController?.tabBar.isHidden = false
    }
    
    @objc
    private func didTapDetailButton() {
        homeView.toolbar.isHidden = false
        homeView.toolbar.detailButton.isSelected = true
        homeView.addSubTaskToFocusedList()
    }
    
    @objc
    private func didTapRoutineButton() {
        homeView.toolbar.routineButton.isSelected = true
        homeView.toolbar.isHidden = false
        homeView.datePicker.isHidden = false
        homeView.routine.isHidden = true
        homeView.priority.isHidden = true
        tabBarController?.tabBar.isHidden = true
        self.hideKeyboardWhenTappedAround()
    }
    
    @objc
    private func didTapPriorityButton() {
        homeView.toolbar.importantButton.isSelected = true
        homeView.toolbar.isHidden = false
        homeView.datePicker.isHidden = true
        homeView.routine.isHidden = true
        homeView.priority.isHidden = false
        tabBarController?.tabBar.isHidden = true
        self.hideKeyboardWhenTappedAround()
    }
    
    @objc
    private func didTapEndRightButton() {
        homeView.datePicker.isHidden = true
        homeView.routine.isHidden = false
    }
    
    @objc
    private func didTapLeftButton() {
        homeView.datePicker.isHidden = false
        homeView.routine.isHidden = true
    }
    
    @objc
    private func didTapRoutineCompleteButton() {
        homeView.routine.isHidden = true
    }
    
    @objc
    private func didTapProrityCompleteButton() {
        homeView.priority.isHidden = true
    }

    @objc
    private func keyboardWillHide(_ notification: Notification) {
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }
    
    // MARK: - Network
    
    private func getDetailTodoList() {
        Task {
            do {
                let date = getSelectedDate()
                let responses = try await detailTasksService.getDetailTasks(date: date)
                print("투두 조회 결과: \(responses)")

                if responses.isEmpty {
                    homeView.todoListView1.configure(with: [])
                    homeView.todoListView2.configure(with: [])
                    homeView.todoListView3.configure(with: [])
                    return
                }

                let todoModels = ToDoModelMapper.map(from: responses)

                if let category1 = todoModels.first(where: { $0.categoryID == 1 }) {
                    homeView.todoListView1.configure(with: category1.mainTasks)
                }
                if let category2 = todoModels.first(where: { $0.categoryID == 2 }) {
                    homeView.todoListView2.configure(with: category2.mainTasks)
                }
                if let category3 = todoModels.first(where: { $0.categoryID == 3 }) {
                    homeView.todoListView3.configure(with: category3.mainTasks)
                }

            } catch {
                print("투두 불러오기 실패: \(error.localizedDescription)")
            }
        }
    }

    private func addMainTask(text: String, categoryIndex: Int) {
        let selectedDate = getSelectedDate()
        let request = AddMainTaskRequest(
            taskContent: text,
            category: "CATEGORY\(categoryIndex)",
            taskDate: "\(selectedDate)T00:00:00Z"
        )

        Task {
            do {
                let response = try await addTaskService.addMainTask(request: request)
                print("메인 태스크 생성 성공: \(response)")
                getDetailTodoList()
            } catch {
                print("메인 태스크 생성 실패: \(error.localizedDescription)")
            }
        }
    }

    private func addSubTask(text: String, mainTaskId: Int) {
        let request = AddSubTaskRequest(content: text)

        Task {
            do {
                let response = try await addTaskService.addSubTask(mainTaskId: mainTaskId, request: request)
                print("서브 태스크 생성 성공: \(response)")
                getDetailTodoList()
            } catch {
                print("서브 태스크 생성 실패: \(error.localizedDescription)")
            }
        }
    }

}

extension HomeViewController: isSelectCalendarCellDelegate {
    func didTapCell() {
        print("셀이 클릭되었어요")
        print(getSelectedDate())
        getDetailTodoList()
    }
}
