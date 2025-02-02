//
//  NetworkManager.swift
//  PipedriveTest
//
//  Created by Dmitrii Gamberov on 01.02.2025.
//

import Foundation
import Network

final class NetworkManager {
    static let shared = NetworkManager()
    
    private var monitor = NWPathMonitor()
    private var currentNetworkStatus: NWPath.Status {
        get {
            return monitor.currentPath.status
        }
    }

    init() {
        monitor.start(queue: DispatchQueue.global(qos: .background))
    }
    
    func request<T: Codable>(type: T.Type, urlString: String, parameters: [String: String]) async throws -> T {
        guard let url = URL(string: urlString) else {
            throw NetworkError.invalidURL
        }

        var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: true)
        
        var queryItems: [URLQueryItem] = []
        for parameter in parameters {
            queryItems.append(URLQueryItem(name: parameter.key, value: parameter.value))
        }
        urlComponents?.queryItems = queryItems
        
        guard let fullURL = urlComponents?.url else {
            throw NetworkError.invalidRequestParams
        }
        
        var request = URLRequest(url: fullURL)
        request.httpMethod = "GET"
        request.addValue("c2ca966a662bf28b88df11a9b0a084d10d20ef2c", forHTTPHeaderField: "x-api-token")
        
        if currentNetworkStatus == .satisfied {
            request.cachePolicy = .reloadIgnoringLocalCacheData
        } else {
            request.cachePolicy = .returnCacheDataDontLoad
        }
             
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let response = response as? HTTPURLResponse,
              200...299 ~= response.statusCode else { throw NetworkError.invalidResponse }
        
        do {
            let decodedData = try JSONDecoder().decode(T.self, from: data)
            return decodedData
        } catch {
            throw NetworkError.failedRequest
        }
    }
}
