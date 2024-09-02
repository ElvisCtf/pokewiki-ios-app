//
//  NetworkManager.swift
//  PokemonWiki
//
//  Created by Elvis Cheng on 5/7/2024.
//

import Foundation
import Alamofire

actor NetworkManager {
    
    static let shared = NetworkManager()
    
    private init() {}
    
    func request<T: Decodable>(
        method: HTTPMethod,
        url: String,
        headers: [String: String] = [String: String](),
        params: Parameters? = nil,
        of type: T.Type
    ) async throws -> T {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        
        return try await withCheckedThrowingContinuation { continuation in
            AF.request(
                url,
                method: method,
                parameters: params,
                encoding: JSONEncoding.default,
                headers: HTTPHeaders(headers)
            ).responseDecodable(of: type, decoder: decoder) { response in
                switch response.result {
                case let .success(data):
                    continuation.resume(returning: data)

                case let .failure(error):
                    continuation.resume(throwing: error)
                }
            }
        }
    }
    
    func downloadData(from url: URL) async throws -> Data {
        let (data, _) = try await URLSession.shared.data(from: url)
        return data
    }
    
}
