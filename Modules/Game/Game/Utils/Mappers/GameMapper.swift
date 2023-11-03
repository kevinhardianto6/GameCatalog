//
//  CategoryMapper.swift
//  Catalog
//
//  Created by Kevin Hardianto on 04/01/23.
//

import UIKit

final class GameMapper {
  
  static func mapGameEntityToGameModel(
    input gameEntity: [GameEntity]
  ) -> [GameModel] {
    return gameEntity.map { result in
      return GameModel(
        id: result.gameId,
        name: result.name,
        released: result.released,
        backgroundImage: result.backgroundImage,
        rating: result.rating,
        ratingTop: result.ratingTop,
        genres: nil,
        shortScreenshots: nil
      )
    }
  }
  
  static func mapGameResponseToGameModel(
    input gameResponse: [GameResponse]
  ) -> [GameModel] {
    return gameResponse.map { result in
      return GameModel(
        id: result.id,
        name: result.name,
        released: result.released,
        backgroundImage: result.backgroundImage,
        rating: result.rating,
        ratingTop: result.ratingTop,
        genres: result.genres,
        shortScreenshots: result.shortScreenshots
      )
    }
  }
  
  static func mapGameDetailResponseToGameDetailModel(
    input gameDetailResponse: GameDetailResponse
  ) -> GameDetailModel {
    return GameDetailModel(
      id: gameDetailResponse.id,
      name: gameDetailResponse.name,
      description: gameDetailResponse.description,
      released: gameDetailResponse.released,
      backgroundImage: gameDetailResponse.backgroundImage,
      rating: gameDetailResponse.rating,
      ratingTop: gameDetailResponse.ratingTop,
      platforms: gameDetailResponse.platforms,
      genres: gameDetailResponse.genres
    )
  }
}
