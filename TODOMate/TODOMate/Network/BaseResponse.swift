//
//  BaseResponse.swift
//  TODOMate
//
//  Created by 이나연 on 5/21/25.
//

import Foundation

struct BaseResponse <T: Decodable> : Decodable {
    let code: String
    let message: String
    let data: T?
}
