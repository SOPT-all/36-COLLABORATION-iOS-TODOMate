//
//  AddMainTaskDTO.swift
//  TODOMate
//
//  Created by 성현주 on 5/22/25.
//

import Foundation

struct AddMainTaskRequest: Codable {
    let taskContent: String
    let category: String
    let taskDate: String  
}

struct AddMainTaskResponse: Codable {
    let mainTaskId: Int
    let taskContent: String
    let importance: String
    let category: String
    let taskDate: String
    let completed: Bool
}
