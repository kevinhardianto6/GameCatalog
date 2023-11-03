//
//  GameModuleEnum.swift
//  Catalog
//
//  Created by Kevin Hardianto on 03/10/23.
//

import UIKit

public enum GameModuleEnum {
  case home
  case detail(game: GameDetailModel, screenshots: [Screenshot])
  case favourite
}
