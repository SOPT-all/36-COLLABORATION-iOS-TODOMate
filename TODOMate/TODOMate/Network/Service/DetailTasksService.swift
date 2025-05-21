//
//  DetailTasksService.swift
//  TODOMate
//
//  Created by 이나연 on 5/21/25.
//

final class DetailTasksService {
    let shared = BaseService.shared
    
    func getDetailTasks(date: String) async throws -> [DetailTasksResponse] {
        do {
            let response: [DetailTasksResponse] = try await shared.request(
                endPoint: .detailMainTasks(date)
            )
            return response
        } catch {
            throw error
        }
    }
}
