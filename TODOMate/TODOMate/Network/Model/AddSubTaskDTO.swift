//
//  AddSubTaskDTO.swift
//  TODOMate
//
//  Created by 성현주 on 5/22/25.
//

import Foundation

struct AddSubTaskRequest: Codable {
    let content: String
}

struct AddSubTaskResponse: Codable {
    let id: Int
    let taskContent: String
    let completed: Bool
    let mainTaskId: Int
}
