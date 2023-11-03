//
//  GameModel.swift
//  Catalog
//
//  Created by Kevin Hardianto on 04/01/23.
//

public struct GameModel {
  var id: Int?
  var name: String?
  var released: String?
  var backgroundImage: String?
  var rating: Double?
  var ratingTop: Int?
  var genres: [Genre]?
  var shortScreenshots: [Screenshot]?
}
