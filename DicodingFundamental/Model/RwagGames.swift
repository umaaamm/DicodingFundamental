//
//  RwagGames.swift
//  DicodingFundamental
//
//  Created by Kurniawan Gigih Lutfi Umam on 06/08/21.
//

import Foundation

// MARK: - RawgGames
struct RawgGames: Codable {
    let count: Int
    let next: String
    let previous: String?
    let results: [Result]
    
    enum CodingKeys: String, CodingKey {
        case count, next, previous, results
    }
}

// MARK: - Result
struct Result: Codable, Identifiable {
    let id: Int
    let slug, name, released: String
    let background_image: String?
    let rating: Double
    let playtime : Int?
    
    enum CodingKeys: String, CodingKey {
        case id, slug, name, released
        case background_image
        case rating
        case playtime
    }
}
