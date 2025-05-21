//
//  DetailTasksResponse.swift
//  TODOMate
//
//  Created by 이나연 on 5/21/25.
//

struct DetailTasksResponse: Codable {
    let mainTaskId: Int
    let taskContent: String
    let importance: String
    let category: String
    let completed: Bool
    let subTasks: [SubTasks]?
}

struct SubTasks: Codable {
    let subTaskId: Int
    let mainTaskId: Int
    let content: String
    let completed: Bool
}
