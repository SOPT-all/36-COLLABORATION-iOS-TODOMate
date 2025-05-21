//
//  DetailTasksResponse.swift
//  TODOMate
//
//  Created by 이나연 on 5/21/25.
//

struct DetailTasksResponse: Decodable {
    let mainTaskId: Int
    let taskContent: String
    let startAt: String
    let endAt: String
    let routineType: String
    let priority: Int
    let category: String
    let taskDate: String
    let completed: Bool
    let subTasks: [SubTasks]
}

struct SubTasks: Decodable {
    let subTaskId: Int
    let content: String
    let completed: Bool
}
