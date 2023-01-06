//
//  DetailInteractor.swift
//  Catalog
//
//  Created by Kevin Hardianto on 02/01/23.
//

import UIKit
import RxSwift

protocol DetailUseCase {
  func checkGameIsFavorite(gameId: Int) -> Observable<Bool>
  func addFavouriteGame(game: GameModel) -> Observable<Bool>
  func deleteFavouriteGame(gameId: Int) -> Observable<Bool>
}

class DetailInteractor: DetailUseCase {
  
  private let repository: GameRepositoryProtocol
  
  required init(repository: GameRepositoryProtocol) {
    self.repository = repository
  }
  
  func checkGameIsFavorite(gameId: Int) -> Observable<Bool> {
    return repository.checkGameIsFavourite(gameId: gameId)
  }
  
  func addFavouriteGame(game: GameModel) -> Observable<Bool> {
    return repository.addFavouriteGame(game: game)
  }
  
  func deleteFavouriteGame(gameId: Int) -> Observable<Bool> {
    return repository.deleteFavouriteGame(gameId: gameId)
  }
}
