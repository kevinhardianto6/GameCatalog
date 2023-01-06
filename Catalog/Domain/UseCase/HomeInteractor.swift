//
//  HomeInteractor.swift
//  Catalog
//
//  Created by Kevin Hardianto on 02/01/23.
//

import UIKit
import RxSwift

protocol HomeUseCase {
  func getAllGames() -> Observable<[GameModel]>
  func getDetailGame(gameId: Int) -> Observable<GameDetailModel>
}

class HomeInteractor: HomeUseCase {
  
  private let repository: GameRepositoryProtocol
  
  required init(repository: GameRepositoryProtocol) {
    self.repository = repository
  }
  
  func getAllGames() -> Observable<[GameModel]> {
    return repository.getAllGames()
  }
  
  func getDetailGame(gameId: Int) -> Observable<GameDetailModel> {
    return repository.getDetailGame(gameId: gameId)
  }
}
