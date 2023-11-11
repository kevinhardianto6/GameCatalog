//
//  DetailViewModel.swift
//  Catalog
//
//  Created by Kevin Hardianto on 01/10/22.
//

import RxCocoa
import RxSwift
import Core

public class DetailViewModel {
  var isFavourite: PublishSubject<Bool> = PublishSubject()
  var add: PublishSubject<Bool> = PublishSubject()
  var remove: PublishSubject<Bool> = PublishSubject()
  var loading: PublishSubject<Bool> = PublishSubject()
  var error: PublishSubject<Bool> = PublishSubject()
  var disposeBag = DisposeBag()
  
  private let detailUseCase: DetailUseCase
  
  public init(detailUseCase: DetailUseCase) {
    self.detailUseCase = detailUseCase
  }
}

extension DetailViewModel {
  func checkGameIsFavourite(gameId: Int) {
    detailUseCase.checkGameIsFavorite(gameId: gameId)
      .observe(on: MainScheduler.instance)
      .subscribe { isFavourite in
        self.isFavourite.onNext(isFavourite)
      } onError: { error in
        self.error.onNext(true)
      } onCompleted: {
        self.loading.onNext(false)
      }.disposed(by: disposeBag)
  }
  
  func addFavouriteGame(game: GameModel) {
    detailUseCase.addFavouriteGame(game: game)
      .observe(on: MainScheduler.instance)
      .subscribe { isAdded in
        self.add.onNext(isAdded)
      } onError: { error in
        self.error.onNext(true)
      } onCompleted: {
      }.disposed(by: disposeBag)
  }
  
  func deleteFavouriteGame(gameId: Int) {
    detailUseCase.deleteFavouriteGame(gameId: gameId)
      .observe(on: MainScheduler.instance)
      .subscribe { isRemove in
        self.remove.onNext(isRemove)
      } onError: { error in
        self.error.onNext(true)
      } onCompleted: {
      }.disposed(by: disposeBag)
  }
}
