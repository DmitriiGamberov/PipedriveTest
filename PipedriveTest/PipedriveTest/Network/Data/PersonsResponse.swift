//
//  PersonsResponse.swift
//  PipedriveTest
//
//  Created by Dmitrii Gamberov on 27.01.2025.
//

struct Pagination: Codable {
    let start: Int
    let limit: Int
    let hasMore: Bool
    let nextStart: Int?
    
    enum CodingKeys: String, CodingKey {
        case start, limit
        case hasMore = "more_items_in_collection"
        case nextStart = "next_start"
    }
}

struct AdditionalData: Codable {
    let pagination: Pagination
}

struct PersonsResponse: Codable {
    let data: [Person]
    let additionalData: AdditionalData
    let success: Bool
    
    enum CodingKeys: String, CodingKey {
        case data, success
        case additionalData = "additional_data"
    }
}
