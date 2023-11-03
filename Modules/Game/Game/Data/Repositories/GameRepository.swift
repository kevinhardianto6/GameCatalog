//
//  GameRepository.swift
//  Catalog
//
//  Created by Kevin Hardianto on 02/01/23.
//

import UIKit
import RxSwift

protocol GameRepositoryProtocol {
  // Remote
  func getAllGames() -> Observable<[GameModel]>
  func getDetailGame(gameId: Int) -> Observable<GameDetailModel>
  
  // Locale
  func checkGameIsFavourite(gameId: Int) -> Observable<Bool>
  func getAllFavouriteGames() -> Observable<[GameModel]>
  func addFavouriteGame(game: GameModel) -> Observable<Bool>
  func deleteFavouriteGame(gameId: Int) -> Observable<Bool>
  func deleteAllFavouriteGames() -> Observable<Bool>
}

final class GameRepository: NSObject {
  
  fileprivate let gameProvider: GameProvider
  fileprivate let gameService: GameService
  
  private init(gameProvider: GameProvider, gameService: GameService) {
    self.gameProvider = gameProvider
    self.gameService = gameService
  }
  
  static let sharedInstance: GameRepository = {
    let service = GameService.sharedInstance
    let storage = GameProvider.sharedInstance
    return GameRepository(gameProvider: storage, gameService: service)
  }()
}

extension GameRepository: GameRepositoryProtocol {
  
  func getAllGames() -> Observable<[GameModel]> {
    return self.gameService.requestGameLists()
      .map { GameMapper.mapGameResponseToGameModel(input: $0) }
  }
  
  func getDetailGame(gameId: Int) -> Observable<GameDetailModel> {
    return self.gameService.requestGameDetails(gameId: gameId)
      .map { GameMapper.mapGameDetailResponseToGameDetailModel(input: $0) }
  }
  
  func checkGameIsFavourite(gameId: Int) -> Observable<Bool> {
    return self.gameProvider.checkGameExistOnFavourite(gameId: gameId)
  }
  
  func getAllFavouriteGames() -> Observable<[GameModel]> {
    return self.gameProvider.getAllFavouriteGames()
      .map { GameMapper.mapGameEntityToGameModel(input: $0) }
  }
  
  func addFavouriteGame(game: GameModel) -> Observable<Bool> {
    return self.gameProvider.addFavouriteGame(game: game)
  }
  
  func deleteFavouriteGame(gameId: Int) -> Observable<Bool> {
    return self.gameProvider.deleteFavouriteGame(gameId: gameId)
  }
  
  func deleteAllFavouriteGames() -> Observable<Bool> {
    return self.gameProvider.deleteAllFavouriteGames()
  }
}
