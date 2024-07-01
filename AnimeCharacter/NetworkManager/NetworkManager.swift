//
//  NetworkManager.swift
//  AnimeCharacter
//
//  Created by Aswanth K on 01/07/24.
//

import Foundation
import Alamofire
import Combine

// Define a NetworkError enum for error handling
enum NetworkError: Error {
    case invalidResponse
    case serverError(String)
    case decodingError(String)
    case unknown
}

// NetworkManager class to handle API requests
class NetworkManager {
    static let shared = NetworkManager() // Singleton instance
    
    private init() {}
    
    // Generic function to make GET requests
    func fetch<T: Decodable>(_ api: AnimeAPI, type: T.Type) -> AnyPublisher<T, NetworkError> {
        let url = api.urlString

        return Future<T, NetworkError> { promise in
            AF.request(url)
                .validate() // Validates the status code
                .responseData { response in
                    switch response.result {
                    case .success(let data):
                        do {
                            let decoder = JSONDecoder()
                            let decodedData = try decoder.decode(T.self, from: data)
                            promise(.success(decodedData))
                        } catch let decodingError {
                            promise(.failure(.decodingError(decodingError.localizedDescription)))
                        }
                    case .failure(let afError):
                        if let data = response.data, let errorResponse = String(data: data, encoding: .utf8) {
                            promise(.failure(.serverError(errorResponse)))
                        } else {
                            promise(.failure(.serverError(afError.localizedDescription)))
                        }
                    }
                }
        }
        .receive(on: DispatchQueue.main) // Ensure the response is handled on the main thread
        .eraseToAnyPublisher()
    }
}

