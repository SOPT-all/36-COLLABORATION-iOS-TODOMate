//
//  HomeView_nayeon.swift
//  TODOMate
//
//  Created by 성현주 on 5/12/25.
//

import UIKit

import SnapKit

final class HomeView_nayeon: BaseUIView {

    // MARK: - UI Components

    let navigationBar = CustomNavigationBar()
    let friendsListView = FriendsListView()
    let profileView = ProfileView()
    let calenderView = CalendarView()

    // MARK: - Custom Methods

    override func setUI() {
        [navigationBar, friendsListView, profileView, calenderView].forEach {
            addSubview($0)
        }
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
        
        profileView.snp.makeConstraints {
            $0.top.equalTo(friendsListView.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(50)
        }
        
        calenderView.snp.makeConstraints {
            $0.top.equalTo(profileView.snp.bottom).offset(28)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(104)
        }
    }
}
