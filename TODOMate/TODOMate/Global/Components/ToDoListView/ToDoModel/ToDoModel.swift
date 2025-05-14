//
//  ToDoModel.swift
//  TODOMate
//
//  Created by 성현주 on 5/15/25.
//

import Foundation

struct MainTask: Decodable {
    let id: UUID
    let text: String
    let isDone: Bool
    let subtasks: [SubTask]
}

struct SubTask: Decodable {
    let id: UUID
    let text: String
    let isDone: Bool
}

extension MainTask {
    static func mockData() -> [MainTask] {
        return [
            MainTask(
                id: UUID(),
                text: "iOS 개발 공부하기",
                isDone: false,
                subtasks: [
                    SubTask(id: UUID(), text: "MVVM 아키텍처 이해", isDone: false),
                    SubTask(id: UUID(), text: "Combine 공부", isDone: true),
                    SubTask(id: UUID(), text: "프로젝트 리팩토링", isDone: false)
                ]
            ),
            MainTask(
                id: UUID(),
                text: "팀플 회의 준비",
                isDone: true,
                subtasks: [
                    SubTask(id: UUID(), text: "요구사항 정리", isDone: true),
                    SubTask(id: UUID(), text: "자료 조사", isDone: true)
                ]
            ),
            MainTask(
                id: UUID(),
                text: "거북목 대탈출",
                isDone: false,
                subtasks: []
            )
        ]
    }
}
