//
//  GameDetail.swift
//  Catalog
//
//  Created by Kevin Hardianto on 01/10/22.
//

public struct GameDetailResponse: Codable {
  public var id: Int?
  public var name: String?
  public var description: String?
  public var released: String?
  public var backgroundImage: String?
  public var rating: Double?
  public var ratingTop: Int?
  public var platforms: [PlatformData]?
  public var genres: [Genre]?
  
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

public struct PlatformData: Codable {
  public var platform: Platform?
}

public struct Platform: Codable {
  public var name: String?
}

public extension Platform {
  static func getPlatformsToString(platforms: [PlatformData]) -> String {
    var stringPlatform = ""
    for (index, platform) in platforms.enumerated() {
      if index != platforms.endIndex-1 {
        stringPlatform.append(String(format: "%@, ", platform.platform?.name ?? ""))
      } else {
        stringPlatform.append(String(format: "%@", platform.platform?.name ?? ""))
      }
    }
    
    return stringPlatform
  }
}
