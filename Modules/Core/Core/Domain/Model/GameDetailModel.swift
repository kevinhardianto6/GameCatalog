//
//  GameDetailModel.swift
//  Catalog
//
//  Created by Kevin Hardianto on 04/01/23.
//

public struct GameDetailModel {
  public var id: Int?
  public var name: String?
  public var description: String?
  public var released: String?
  public var backgroundImage: String?
  public var rating: Double?
  public var ratingTop: Int?
  public var platforms: [PlatformData]?
  public var genres: [Genre]?
}
