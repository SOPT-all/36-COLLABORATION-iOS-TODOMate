//
//  AddTaskService.swift
//  TODOMate
//
//  Created by 성현주 on 5/22/25.
//

import Foundation

final class AddTaskService {
    let shared = BaseService.shared

    func addMainTask(request: AddMainTaskRequest) async throws -> AddMainTaskResponse {
        do {
            let response: AddMainTaskResponse = try await shared.request(
                endPoint: .postMainTasks,
                body: request
            )
            return response
        } catch {
            throw error
        }
    }

    func addSubTask(mainTaskId: Int, request: AddSubTaskRequest) async throws -> AddSubTaskResponse {
        return try await shared.request(
            endPoint: .postSubTasks(mainTaskId),
            body: request
        )
    }
}
