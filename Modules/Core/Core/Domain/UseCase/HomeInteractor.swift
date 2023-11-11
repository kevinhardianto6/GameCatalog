//
//  HomeInteractor.swift
//  Catalog
//
//  Created by Kevin Hardianto on 02/01/23.
//

import UIKit
import RxSwift

public protocol HomeUseCase {
  func getAllGames() -> Observable<[GameModel]>
  func getDetailGame(gameId: Int) -> Observable<GameDetailModel>
}

public class HomeInteractor: HomeUseCase {
  private let gameRepository: GameRepositoryProtocol
  
  required init(gameRepository: GameRepositoryProtocol) {
    self.gameRepository = gameRepository
  }
  
  public func getAllGames() -> Observable<[GameModel]> {
    return gameRepository.getAllGames()
  }
  
  public func getDetailGame(gameId: Int) -> Observable<GameDetailModel> {
    return gameRepository.getDetailGame(gameId: gameId)
  }
}
