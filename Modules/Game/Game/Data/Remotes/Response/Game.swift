//
//  Game.swift
//  Catalog
//
//  Created by Kevin Hardianto on 01/10/22.
//

struct GamesResponse: Codable {
  var results: [GameResponse]?
}

struct GameResponse: Codable {
  var id: Int?
  var name: String?
  var released: String?
  var backgroundImage: String?
  var rating: Double?
  var ratingTop: Int?
  var genres: [Genre]?
  var shortScreenshots: [Screenshot]?
  
  enum CodingKeys: String, CodingKey {
    case id
    case name
    case released
    case backgroundImage = "background_image"
    case rating
    case ratingTop = "rating_top"
    case genres
    case shortScreenshots = "short_screenshots"
  }
}

struct Genre: Codable {
  var name: String?
}

public struct Screenshot: Codable {
  var image: String?
}

extension Genre {
  static func getGenresToString(genres: [Genre]) -> String {
    var stringGenre = ""
    for (index, genre) in genres.enumerated() {
      if index != genres.endIndex-1 {
        stringGenre.append(String(format: "%@, ", genre.name ?? ""))
      } else {
        stringGenre.append(String(format: "%@", genre.name ?? ""))
      }
    }
    
    return stringGenre
  }
}
