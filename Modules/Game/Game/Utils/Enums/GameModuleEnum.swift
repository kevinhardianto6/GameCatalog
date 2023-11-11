//
//  GameModuleEnum.swift
//  Game
//
//  Created by Kevin Hardianto on 12/11/23.
//

import UIKit
import Core

public enum GameModuleEnum {
  case home
  case detail(game: GameDetailModel, screenshots: [Screenshot])
  case favourite
}
