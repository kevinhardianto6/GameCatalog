//
//  FavouriteViewModel.swift
//  Catalog
//
//  Created by Kevin Hardianto on 11/10/22.
//

import RxSwift
import RxCocoa

public class FavouriteViewModel {
  
  var success: PublishSubject<[GameModel]> = PublishSubject()
  var deleted: PublishSubject<Bool> = PublishSubject()
  var detail: PublishSubject<GameDetailModel> = PublishSubject()
  var error: PublishSubject<Bool> = PublishSubject()
  var disposeBag = DisposeBag()
  
  private let favouriteUseCase: FavouriteUseCase
  private let favouriteRouter = FavouriteRouter()
  
  public init(favouriteUseCase: FavouriteUseCase) {
    self.favouriteUseCase = favouriteUseCase
  }
  
  func makeDetailView(game: GameDetailModel) -> UIViewController {
    return favouriteRouter.makeDetailView(game: game)
  }
}

extension FavouriteViewModel {
  func getAllFavouriteGames() {
    favouriteUseCase.getAllFavouriteGames()
      .observe(on: MainScheduler.instance)
      .subscribe { favouriteGames in
        self.success.onNext(favouriteGames)
      } onError: { error in
        self.error.onNext(true)
      } onCompleted: {
      }.disposed(by: disposeBag)
  }
  
  func deleteAllFavouriteGames() {
    favouriteUseCase.deleteAllFavouriteGames()
      .observe(on: MainScheduler.instance)
      .subscribe { isDeleted in
        self.deleted.onNext(isDeleted)
      } onError: { error in
        self.error.onNext(true)
      } onCompleted: {
      }.disposed(by: disposeBag)
  }
  
  func getDetailGame(gameId: Int) {
    favouriteUseCase.getDetailGame(gameId: gameId)
      .observe(on: MainScheduler.instance)
      .subscribe { game in
        self.detail.onNext(game)
      } onError: { error in
        self.error.onNext(true)
      }.disposed(by: disposeBag)
  }
}
