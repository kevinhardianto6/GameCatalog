//
//  HomeViewModel.swift
//  Catalog
//
//  Created by Kevin Hardianto on 01/10/22.
//

import RxSwift
import RxCocoa
import Core

public class HomeViewModel {
  var games: PublishSubject<[GameModel]> = PublishSubject()
  var detail: PublishSubject<GameDetailModel> = PublishSubject()
  var loading: PublishSubject<Bool> = PublishSubject()
  var error: PublishSubject<Bool> = PublishSubject()
  var disposeBag: DisposeBag = DisposeBag()
  
  private let homeUseCase: HomeUseCase
  private let homeRouter = HomeRouter()
  
  public init(homeUseCase: HomeUseCase) {
    self.homeUseCase = homeUseCase
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

extension HomeViewModel {
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
    loading.onNext(true)
    homeUseCase.getDetailGame(gameId: gameId)
      .observe(on: MainScheduler.instance)
      .subscribe { game in
        self.detail.onNext(game)
      } onError: { error in
        self.error.onNext(true)
      } onCompleted: {
        self.loading.onNext(false)
      }.disposed(by: disposeBag)
  }
}
