//
//  NetworkManager.swift
//  GithubRepos
//
//  Created by Giorgi Shukakidze on 12.08.21.
//

import Foundation
import Combine

final class NetworkManager {
    func networkRequest<Result: Codable>(
        path: String,
        baseUrl: String = URLRepository.baseUrl,
        queryItems: [URLQueryItem]? = nil
    ) -> AnyPublisher<Result, NetworkError> {
        let url = URL(string: path, relativeTo: URL(string: baseUrl))
                
        return networkRequest(for: url, queryItems: queryItems)
    }
    
    func networkRequest<Result: Codable>(for url: URL?, queryItems: [URLQueryItem]? = nil) -> AnyPublisher<Result, NetworkError> {
        guard let url = url else {
            return Future { promise in promise(.failure(NetworkError.invalidURL)) }.eraseToAnyPublisher()
        }
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        
        var components = URLComponents(url: url, resolvingAgainstBaseURL: true)!
        components.queryItems = queryItems
        
        let request = URLRequest(url: components.url!)
        
        return URLSession.shared.dataTaskPublisher(for: request)
            .map { $0.data }
            .mapError { failure in NetworkError.responseError(failure.localizedDescription) }
            .decode(type: Result.self, decoder: decoder)
            .mapError { error in NetworkError.parseError(error.localizedDescription)}
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
    }
}


enum NetworkError: Error {
    case invalidURL
    case responseError(String)
    case parseError(String)
}
