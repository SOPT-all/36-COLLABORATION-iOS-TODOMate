//
//  NetworkLogger.swift
//  TODOMate
//
//  Created by 이나연 on 5/21/25.
//

import Foundation

final class NetworkLogger {
    static let shared = NetworkLogger()
    
    private init() { }

    static var isEnabled = true

    static var teamTag = "[TodoMate-iOS]"

    private static let dateFormatter: DateFormatter = {
        let df = DateFormatter()
        df.dateFormat = "yyyy-MM-dd HH:mm:ss.SSS"
        return df
    }()

    private static func fileName(from path: String) -> String {
        return URL(fileURLWithPath: path).lastPathComponent
    }

    private static func header(_ title: String) -> String {
        return """
            \n\(teamTag) —— [\(title)] —— \(dateFormatter.string(from: Date()))
            """
    }

    static func requestLog(
        _ request: URLRequest,
        file: String = #file,
        function: String = #function,
        line: Int = #line
    ) {
        guard isEnabled else { return }
        let urlString = request.url?.absoluteString ?? "–"
        let method = request.httpMethod ?? "–"
        var output = header("REQUEST: ")

        output += """
            \n\(fileName(from: file)):\(line) \(function)
            URL: \(urlString)
            Method: \(method)
            """

        if let headers = request.allHTTPHeaderFields {
            for (k, v) in headers {
                output += "\n\(k): \(v)"
            }
        }

        if let body = request.httpBody,
            let str = String(data: body, encoding: .utf8) {
            output += "\n\nBody:\n\(str)"
        }

        print(output)
        print(String(repeating: "—", count: 60))
    }

    static func responseLog(
        _ response: HTTPURLResponse?,
        data: Data?,
        file: String = #file,
        function: String = #function,
        line: Int = #line
    ) {
        guard isEnabled else { return }

        let status: String
        if let httpRes = response {
            status = "\(httpRes.statusCode)"
        } else {
            status = "–"
        }

        var output = header("RESPONSE 🌀")

        output += "\n\(fileName(from: file)):\(line) \(function)"
        output += "\nStatus Code: \(status)"

        if let data = data,
            let str = String(data: data, encoding: .utf8)
        {
            output += "\n\nBody:\n\(str)"
        }

        print(output)
        print(String(repeating: "—", count: 60))
    }
}
