//
//  HTTPMethodType.swift
//  TODOMate
//
//  Created by 이나연 on 5/21/25.
//

import Foundation

enum HTTPMethodType {
    case get
    case post
    case patch
    
    var key: String {
        switch self {
        case .get:
            "GET"
        case .post:
            "POST"
        case .patch:
            "PATCH"
        }
    }
}

let defaultHeaders = ["Content-Type": "application/json", "userId": "1"]
