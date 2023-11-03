//
//  GameService.swift
//  Catalog
//
//  Created by Kevin Hardianto on 01/10/22.
//

import UIKit
import Core
import Alamofire
import RxSwift

protocol GameServiceProtocol {
  func requestGameLists() -> Observable<[GameResponse]>
  func requestGameDetails(gameId: Int) -> Observable<GameDetailResponse>
}

final class GameService: NSObject {
  static let sharedInstance = GameService()
}

extension GameService: GameServiceProtocol {
  func requestGameLists() -> Observable<[GameResponse]> {
    return Observable.create { observer in
      if let url = URL(string: Endpoints.Gets.listGames.url) {
        AF.request(url)
          .validate()
          .responseDecodable(of: GamesResponse.self) { response in
            switch response.result {
            case .success(let value):
              observer.onNext(value.results ?? [GameResponse]())
              observer.onCompleted()
            case .failure(let error):
              observer.onError(error)
            }
          }
      }
      return Disposables.create()
    }
  }
  
  func requestGameDetails(gameId: Int) -> Observable<GameDetailResponse> {
    return Observable.create { observer in
      if let url = URL(string: Endpoints.Gets.detailGame(gameId: gameId).url) {
        AF.request(url)
          .validate()
          .responseDecodable(of: GameDetailResponse.self) { response in
            switch response.result {
            case .success(let value):
              observer.onNext(value)
              observer.onCompleted()
            case .failure(let error):
              observer.onError(error)
            }
          }
      }
      return Disposables.create()
    }
  }
}
