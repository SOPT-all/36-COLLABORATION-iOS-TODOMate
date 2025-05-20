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
    
    let friendsListView = FriendsListView()
    let profileView = ProfileView()
    let calenderView = CalendarView()

    private let scrollView = UIScrollView()
    let contentView = UIView()

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
    
    let datePicker = CustomDatePicker()
    let toolbar = ToolBar()
    let routine = Routine()
    let priority = Priority()

    let line = UIImageView().then {
        $0.contentMode = .scaleAspectFit
        $0.image = .reLine
    }
    
    let aiButton = CapsuleButton().then {
        $0.type = .ai
        $0.text = "AI 할일생성"
    }

    let listMenuView = UIView()
    
    let listMenuIcon = UIImageView().then {
        $0.contentMode = .scaleAspectFit
        $0.image = .reIconList
    }
     
    let listMenuText = UILabel().then {
        $0.font = .cap_med_12
        $0.text = "리스트 메뉴"
        $0.textColor = .black
    }
    
    // MARK: - Custom Methods

    override func setUI() {
        addSubviews(navigationBar, scrollView, friendsListView, datePicker, toolbar, routine, priority)
        scrollView.addSubview(contentView)

        contentView.addSubviews(
            profileView, calenderView,
            categoryButton1, todoListView1,
            categoryButton2, todoListView2,
            categoryButton3, todoListView3,
            line, aiButton, listMenuView
        )
        
        listMenuView.addSubviews(listMenuIcon, listMenuText)
        
        datePicker.tag = 1001
        routine.tag = 1002
        priority.tag = 1003
        
        datePicker.isHidden = true
        routine.isHidden = true
        priority.isHidden = true
    }

    override func setLayout() {
        navigationBar.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(48)
        }
        
        friendsListView.snp.makeConstraints {
            $0.top.equalTo(navigationBar.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(93)
        }
        
        scrollView.snp.makeConstraints {
            $0.top.equalTo(friendsListView.snp.bottom)
            $0.leading.trailing.bottom.equalToSuperview()
        }

        contentView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.width.equalTo(scrollView)
        }
        
        profileView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(50)
        }
        
        calenderView.snp.makeConstraints {
            $0.top.equalTo(profileView.snp.bottom).offset(28)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(104)
        }

        categoryButton1.snp.makeConstraints {
            $0.top.equalTo(calenderView.snp.bottom).offset(33)
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
        
        line.snp.makeConstraints {
            $0.top.equalTo(todoListView3.snp.bottom).offset(22)
            $0.leading.trailing.equalToSuperview().inset(24)
        }

        aiButton.snp.makeConstraints {
            $0.top.equalTo(line.snp.bottom).offset(20)
            $0.leading.equalToSuperview().inset(20)
            $0.bottom.equalToSuperview().inset(80)
        }
        
        listMenuView.snp.makeConstraints {
            $0.top.equalTo(line.snp.bottom).offset(20)
            $0.trailing.equalToSuperview().inset(20)
            $0.bottom.equalToSuperview().inset(80)
        }
        
        listMenuIcon.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview()
            $0.width.equalTo(10)
            $0.height.equalTo(9)
        }
        
        listMenuText.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(listMenuIcon.snp.trailing).offset(8)
            $0.trailing.equalToSuperview()
        }
        
        datePicker.snp.makeConstraints {
            $0.top.equalTo(toolbar.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
            $0.height.equalTo(278)
        }
        
        toolbar.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
            $0.height.equalTo(50)
        }
        
        routine.snp.makeConstraints {
            $0.top.equalTo(toolbar.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(278)
        }
        
        priority.snp.makeConstraints {
            $0.top.equalTo(toolbar.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
            $0.height.equalTo(278)
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
