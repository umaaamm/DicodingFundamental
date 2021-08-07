//
//  DetailGamesModel.swift
//  DicodingFundamental
//
//  Created by Kurniawan Gigih Lutfi Umam on 06/08/21.
//

import Foundation

// MARK: - DetailGamesModel
struct DetailGamesModel: Codable, Identifiable {
    let id: Int?
    let slug, name, nameOriginal, description: String?
    let released: String?
    let backgroundImage: String?
    let backgroundImageAdditional: String?
    let rating: Double?
    let playtime: Int?
    enum CodingKeys: String, CodingKey {
        case id, slug, name
        case nameOriginal
        case description
        case released
        case backgroundImage
        case backgroundImageAdditional
        case rating
        case playtime
    }
}
