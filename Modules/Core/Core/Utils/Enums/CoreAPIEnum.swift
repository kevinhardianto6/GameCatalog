//
//  CoreAPIEnum.swift
//  Core
//
//  Created by Kevin Hardianto on 11/11/23.
//

import UIKit

enum CoreAPIEnum {
  static let listGames = { (baseKey: String) in
    "/api/games?key=\(baseKey)"
  }
  
  static let detailGame = { (gameId: Int, baseKey: String) in
    "/api/games/\(gameId)?key=\(baseKey)"
  }
}
