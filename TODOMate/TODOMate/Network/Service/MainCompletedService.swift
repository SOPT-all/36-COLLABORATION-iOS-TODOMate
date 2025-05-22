//
//  MainCompletedService.swift
//  TODOMate
//
//  Created by LEESOOYONG on 5/22/25.
//

final class MainCompletedService {
    let shared = BaseService.shared
    
    func patchMainTask(id: Int, request: MainCompletedRequest) async throws -> VoidType {
        do {
            let response: VoidType = try await shared.request(
                endPoint: .patchMainTasks(id),
                body: request
            )
            return response
        } catch {
            throw error
        }
    }
}
