//
//  SubTaskPatchService.swift
//  TODOMate
//
//  Created by 이나연 on 5/22/25.
//

struct VoidType: Decodable {}

final class SubTaskPatchService {
    let shared = BaseService.shared
    
    func patchSubTask(id: Int, request: SubTaskPatchRequest) async throws -> BaseResponse<VoidType> {
        do {
            let response: BaseResponse<VoidType> = try await shared.request(
                endPoint: .patchSubTasks(id),
                body: request
            )
            return response
        } catch {
            throw error
        }
    }
}
