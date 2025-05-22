//
//  MainCompletedService.swift
//  TODOMate
//
//  Created by LEESOOYONG on 5/22/25.
//

struct VoidType: Decodable {}

final class MainCompletedService {
    let shared = BaseService.shared
    
    func patchMainTask(id: Int, request: MainCompletedRequest) async throws -> BaseResponse<VoidType> {
        do {
            let response: BaseResponse<VoidType> = try await shared.request(
                endPoint: .patchMainTasks(id),
                body: request
            )
            return response
        } catch {
            throw error
        }
    }
}
