//
//  DetailTasksService.swift
//  TODOMate
//
//  Created by 이나연 on 5/21/25.
//

final class DetailTasksService {
    let network = BaseService.shared
    
    func getDetailTasks(date: String) async throws -> DetailTasksResponse {
        do {
            let response: DetailTasksResponse = try await network.request(
                endPoint: .detailMainTasks(date)
                )
            return response
        } catch {
            throw error
        }
    }
}
