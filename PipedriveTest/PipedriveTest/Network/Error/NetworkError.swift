//
//  NetworkError.swift
//  PipedriveTest
//
//  Created by Dmitrii Gamberov on 01.02.2025.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case invalidResponse
    case failedRequest
    case invalidData
    case invalidRequestParams
}
