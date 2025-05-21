//
//  ToDoModel.swift
//  TODOMate
//
//  Created by 성현주 on 5/15/25.
//

import Foundation

struct ToDoModel: Decodable {
    let categoryID: Int
    let mainTasks: [MainTask]
}

struct MainTask: Decodable {
    let id: Int
    let text: String
    let isDone: Bool
    let subtasks: [SubTask]
}

struct SubTask: Decodable {
    let id: Int
    let text: String
    let isDone: Bool
}
