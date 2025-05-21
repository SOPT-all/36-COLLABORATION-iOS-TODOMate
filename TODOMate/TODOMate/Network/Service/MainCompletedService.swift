//
//  MainCompletedService.swift
//  TODOMate
//
//  Created by LEESOOYONG on 5/22/25.
//

final class MainCompletedService {
    let shared = BaseService.shared
    
    func patchMainCompleted(request: MainCompletedRequest, taskId: Int) async throws -> [MainCompletedRequest] {
        do {
            let response: [MainCompletedRequest] = try await shared.request(
                endPoint: .patchMainTasks(taskId),
                body: request
            )
            return response
        } catch {
            throw error
        }
    }
}
