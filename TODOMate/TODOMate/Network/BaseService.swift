//
//  BaseService.swift
//  TODOMate
//
//  Created by 이나연 on 5/21/25.
//

import Foundation

final class BaseService {
    static let shared = BaseService()
    
    private init() { }
    
    func request <Response: Decodable>(
        endPoint: EndPoint,
        body: Encodable? = nil
    ) async throws -> Response {
        let url = BASE_URL + endPoint.url
        
        guard let encodedURL = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
            throw NetworkError.urlError
        }
        
        guard let url = URL(string: encodedURL) else {
            throw NetworkError.urlError
        }
        
        var request = URLRequest(url: url)
        
        request.httpMethod = endPoint.httpMethod.key
        endPoint.headers.forEach {
            request.addValue($0.value, forHTTPHeaderField: $0.key)
        }
        
        if let body {
            let requestBody = try makeRequestBody(data: body)
            request.httpBody = requestBody
        }
        
        NetworkLogger.requestLog(request)
        
        return try await requestToResponse(request: request)
    }
    
    // MARK: - Private Method
    
    private func makeRequestBody <Body: Encodable>(data: Body) throws -> Data {
        do {
            let jsonEncoder = JSONEncoder()
            let requestBody = try jsonEncoder.encode(data)
            
            return requestBody
        } catch {
            throw NetworkError.requestEncodingError
        }
    }
    
    private func requestToResponse <Response: Decodable> (request: URLRequest) async throws -> Response {
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkError.httpURLResponseError
        }
        
        NetworkLogger.responseLog(httpResponse, data: data)
        
        do {
            print("type\(Response.self)")
            let decoded = try JSONDecoder().decode(BaseResponse<Response>.self, from: data)
            
            guard let data = decoded.data else {
                throw NetworkError.noData
            }
            
            let successCodes = ["s2000", "s2010", "s2040"]
            guard successCodes.contains(decoded.code) else {
                throw NetworkError.serverErrorMessage(decoded.message)
            }

           return data
        } catch {
            throw NetworkError.responseDecodingError
        }
    }
}
