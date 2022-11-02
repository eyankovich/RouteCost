//
//  ApiRequestManager.swift
//  RouteCost
//
//  Created by Егор Янкович on 1.11.22.
//

import Foundation

enum HTTPMethod: String {
    case GET = "GET"
    case POST = "POST"
    case PUT = "PUT"
    case PATHC = "PATCH"
    case DELETE = "DELETE"
}


protocol DataRequest {
    associatedtype Responce
    var url: String { get }
    var method: HTTPMethod { get }
    var headers: [String : String] { get }
    var queryItems: [String : String] { get }
    func decode(_ data: Data) throws -> Responce
}

extension DataRequest where Responce: Decodable {
    func decode(_ data: Data) throws -> Responce {
        let decoder = JSONDecoder()
        return try decoder.decode(Responce.self, from: data)
    }
}

extension DataRequest {
    var headers: [String: String] {
        [:]
    }
    
    var queryItems: [String: String] {
        [:]
    }
}

protocol NetworkService {
    func request<Request: DataRequest> (_ request: Request, completion: @escaping(Result<Request.Responce, Error>) -> Void)
}


final class ApiRequestManager: NetworkService {
    
    func request<Request>(_ request: Request, completion: @escaping (Result<Request.Responce, Error>) -> Void) where Request : DataRequest {
        guard var urlComponents = URLComponents(string: request.url) else {
            let error = NSError(domain: "error", code: 404, userInfo: nil)
            return completion(.failure(error))
        }
        
        var queryItems: [URLQueryItem] = []
        
        request.queryItems.forEach({
            let urlQueryItem = URLQueryItem(name: $0.key, value: $0.value)
            urlComponents.queryItems?.append(urlQueryItem)
            queryItems.append(urlQueryItem)
        })
        
        urlComponents.queryItems = queryItems
        
        guard let url = urlComponents.url else {
            let error = NSError(domain: "error", code: 404, userInfo: nil)
            return completion(.failure(error))
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = request.method.rawValue
        urlRequest.allHTTPHeaderFields = request.headers
        
        URLSession.shared.dataTask(with: urlRequest) { data, responce, error in
            if let error = error {
                return completion(.failure(error))
            }
            
            guard let response = responce as? HTTPURLResponse, 200..<300 ~= response.statusCode else {
                return completion(.failure(NSError()))
            }
            
            guard let data = data else {
                return completion(.failure(NSError()))
            }
            
            do {
                try completion(.success(request.decode(data)))
            } catch let error as NSError {
                completion(.failure(error))
            }
        }
        .resume()
    }
}
