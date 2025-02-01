//
//  PersonAPI.swift
//  PipedriveTest
//
//  Created by Dmitrii Gamberov on 01.02.2025.
//

import Foundation

protocol PersonsApiProtocol {
    func getPersons(cursor: Int, completion: (Result<PersonsResponse, NetworkError>) -> Void) async throws
}

final class PersonsAPI: PersonsApiProtocol {
    static let shared = PersonsAPI()
    
    func getPersons(cursor: Int, completion: (Result<PersonsResponse, NetworkError>) -> Void) async throws {
        let urlString = "https://bold-basin.pipedrive.com/api/v1/persons"
        let parameters = ["start": String(cursor), "limit": "20"]
        
        do {
            let response = try await NetworkManager.shared.request(type: PersonsResponse.self, urlString: urlString, parameters: parameters)
            completion(.success(response))
        } catch let error as NetworkError {
            completion(.failure(error))
        }
    }
}
