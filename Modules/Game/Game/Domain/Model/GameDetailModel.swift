//
//  GameDetailModel.swift
//  Catalog
//
//  Created by Kevin Hardianto on 04/01/23.
//

public struct GameDetailModel {
  var id: Int?
  var name: String?
  var description: String?
  var released: String?
  var backgroundImage: String?
  var rating: Double?
  var ratingTop: Int?
  var platforms: [PlatformData]?
  var genres: [Genre]?
}
