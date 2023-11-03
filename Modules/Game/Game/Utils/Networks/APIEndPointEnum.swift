//
//  APIEndPointEnum.swift
//  Catalog
//
//  Created by Kevin Hardianto on 01/10/22.
//

import UIKit

struct API {
  static let baseUrl = "https://api.rawg.io"
  static let baseKey: String = {
    if let path = Bundle.main.path(forResource: "Info", ofType: "plist") {
      let dictionary = NSDictionary(contentsOfFile: path)
      return dictionary?["BASE_KEY"] as? String ?? ""
    } else {
      return ""
    }
  }()
}

protocol Endpoint {
  var url: String { get }
}

enum Endpoints {
  
  enum Gets: Endpoint {
    case listGames
    case detailGame(gameId: Int)
    
    public var url: String {
      switch self {
      case .listGames:
        return "\(API.baseUrl)/api/games?key=\(API.baseKey)"
      case .detailGame(let gameId):
        return "\(API.baseUrl)/api/games/\(gameId)?key=\(API.baseKey)"
      }
    }
  }
}
