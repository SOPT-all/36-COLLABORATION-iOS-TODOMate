//
//  EndPoint.swift
//  TODOMate
//
//  Created by 이나연 on 5/21/25.
//

import Foundation

enum EndPoint {
    case detailMainTasks(String)
    case postMainTasks
    case postSubTasks(Int)
    case patchMainTasks(Int)
    case patchSubTasks(Int)
    
    var httpMethod: HTTPMethodType {
        switch self {
        case .detailMainTasks:
            .get
        case .postMainTasks, .postSubTasks:
            .post
        case .patchMainTasks, .patchSubTasks:
            .patch
        }
    }
    
    var url: String {
        switch self {
        case .detailMainTasks(let date):
            "/main-tasks/detail?date=\(date)"
        case .postMainTasks:
            "/main-tasks"
        case .postSubTasks:
            "/sub-tasks"
        case .patchMainTasks:
            "/main-tasks"
        case .patchSubTasks:
            "/sub-tasks"
        }
    }
    
    var headers: [String: String] {
        switch self {
        case .postSubTasks(let taskId):
            return defaultHeaders.merging(["taskId": "\(taskId)"]) { _, new in new }
        case .patchSubTasks(let taskId):
            return defaultHeaders.merging(["taskId": "\(taskId)"]) { _, new in new }
        default:
            return defaultHeaders
        }
    }

}
