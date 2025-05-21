//
//  HomeModel.swift
//  TODOMate
//
//  Created by 성현주 on 5/22/25.
//

import Foundation

struct ToDoModelMapper {
    static func map(from responses: [DetailTasksResponse]) -> [ToDoModel] {
        let grouped = Dictionary(grouping: responses) { $0.category }

        let categoryMap = [
            "CATEGORY1": 1,
            "CATEGORY2": 2,
            "CATEGORY3": 3
        ]

        return grouped.compactMap { (categoryKey, tasks) -> ToDoModel? in
            guard let categoryID = categoryMap[categoryKey] else { return nil }

            let mainTasks = tasks.map { task in
                MainTask(
                    id: task.mainTaskId,
                    text: task.taskContent,
                    isDone: task.completed,
                    subtasks: task.subTasks?.map {
                        SubTask(id: $0.subTaskId, text: $0.content, isDone: $0.completed)
                    } ?? []
                )
            }

            return ToDoModel(categoryID: categoryID, mainTasks: mainTasks)
        }
    }
}
