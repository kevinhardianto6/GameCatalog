//
//  DetailInteractor.swift
//  Catalog
//
//  Created by Kevin Hardianto on 02/01/23.
//

import UIKit
import RxSwift

public protocol DetailUseCase {
  func checkGameIsFavorite(gameId: Int) -> Observable<Bool>
  func addFavouriteGame(game: GameModel) -> Observable<Bool>
  func deleteFavouriteGame(gameId: Int) -> Observable<Bool>
}

public class DetailInteractor: DetailUseCase {
  private let gameRepository: GameRepositoryProtocol
  
  required init(gameRepository: GameRepositoryProtocol) {
    self.gameRepository = gameRepository
  }
  
  public func checkGameIsFavorite(gameId: Int) -> Observable<Bool> {
    return gameRepository.checkGameIsFavourite(gameId: gameId)
  }
  
  public func addFavouriteGame(game: GameModel) -> Observable<Bool> {
    return gameRepository.addFavouriteGame(game: game)
  }
  
  public func deleteFavouriteGame(gameId: Int) -> Observable<Bool> {
    return gameRepository.deleteFavouriteGame(gameId: gameId)
  }
}
