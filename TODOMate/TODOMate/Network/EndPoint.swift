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
    case postSubTasks
    case patchMainTasks
    case patchSubTasks
    
    var httpMethod: HTTPMethodType{
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
        defaultHeaders
    }
}
