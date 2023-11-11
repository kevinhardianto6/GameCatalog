//
//  GameModel.swift
//  Core
//
//  Created by Kevin Hardianto on 04/01/23.
//

public struct GameModel {
  public var id: Int?
  public var name: String?
  public var released: String?
  public var backgroundImage: String?
  public var rating: Double?
  public var ratingTop: Int?
  public var genres: [Genre]?
  public var shortScreenshots: [Screenshot]?
  
  public init(id: Int? = nil, name: String? = nil, released: String? = nil, backgroundImage: String? = nil, rating: Double? = nil, ratingTop: Int? = nil, genres: [Genre]? = nil, shortScreenshots: [Screenshot]? = nil) {
    self.id = id
    self.name = name
    self.released = released
    self.backgroundImage = backgroundImage
    self.rating = rating
    self.ratingTop = ratingTop
    self.genres = genres
    self.shortScreenshots = shortScreenshots
  }
}
