//
//  HomeViewModel.swift
//  Catalog
//
//  Created by Kevin Hardianto on 01/10/22.
//

import RxSwift
import RxCocoa

protocol HomeViewModelProtocol {
  var games: PublishSubject<[GameModel]> { get }
  var detail: PublishSubject<GameDetailModel> { get }
  var loading: PublishSubject<Bool> { get }
  var error: PublishSubject<Bool> { get }
  var disposeBag: DisposeBag { get }
  
  func getAllGames()
  func getDetailGame(gameId: Int)
  func getSearchGame(games: [GameModel], query: String)
  
  func makeDetailView(game: GameDetailModel, screenshots: [Screenshot]) -> UIViewController
}

class HomeViewModel: HomeViewModelProtocol {
  
  var games: PublishSubject<[GameModel]> = PublishSubject()
  var detail: PublishSubject<GameDetailModel> = PublishSubject()
  var loading: PublishSubject<Bool> = PublishSubject()
  var error: PublishSubject<Bool> = PublishSubject()
  var disposeBag: DisposeBag = DisposeBag()
  
  private let homeUseCase: HomeUseCase
  private let homeRouter = HomeRouter()
  
  init(homeUseCase: HomeUseCase) {
    self.homeUseCase = homeUseCase
  }
  
  func getAllGames(){
    loading.onNext(true)
    homeUseCase.getAllGames()
      .observe(on: MainScheduler.instance)
      .subscribe { games in
        self.games.onNext(games)
      } onError: { _ in
        self.error.onNext(true)
      } onCompleted: {
        self.loading.onNext(false)
      }.disposed(by: disposeBag)
  }
  
  func getDetailGame(gameId: Int) {
    homeUseCase.getDetailGame(gameId: gameId)
      .observe(on: MainScheduler.instance)
      .subscribe { game in
        self.detail.onNext(game)
      } onError: { error in
        self.error.onNext(true)
      }.disposed(by: disposeBag)
  }
  
  func getSearchGame(games: [GameModel], query: String) {
    let filteredGames = games.filter { game in
      game.name!
        .lowercased()
        .contains(query.lowercased())
    }
    self.games.onNext(filteredGames)
  }
  
  func makeDetailView(game: GameDetailModel, screenshots: [Screenshot]) -> UIViewController {
    homeRouter.makeDetailView(game: game, screenshots: screenshots)
  }
}
