//
//  GameDetail.swift
//  Catalog
//
//  Created by Kevin Hardianto on 01/10/22.
//

struct GameDetailResponse: Codable {
  var id: Int?
  var name: String?
  var description: String?
  var released: String?
  var backgroundImage: String?
  var rating: Double?
  var ratingTop: Int?
  var platforms: [PlatformData]?
  var genres: [Genre]?
  
  enum CodingKeys: String, CodingKey {
    case id
    case name
    case description
    case released
    case backgroundImage = "background_image"
    case rating
    case ratingTop = "rating_top"
    case platforms
    case genres
  }
}

struct PlatformData: Codable {
  var platform: Platform?
}

struct Platform: Codable {
  var name: String?
}
