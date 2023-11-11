//
//  Game.swift
//  Catalog
//
//  Created by Kevin Hardianto on 01/10/22.
//

public struct GamesResponse: Codable {
  public var results: [GameResponse]?
}

public struct GameResponse: Codable {
  public var id: Int?
  public var name: String?
  public var released: String?
  public var backgroundImage: String?
  public var rating: Double?
  public var ratingTop: Int?
  public var genres: [Genre]?
  public var shortScreenshots: [Screenshot]?
  
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

public struct Genre: Codable {
  public var name: String?
}

public struct Screenshot: Codable {
  public var image: String?
}

public extension Genre {
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
