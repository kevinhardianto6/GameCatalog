//
//  HomeRouter.swift
//  Catalog
//
//  Created by Kevin Hardianto on 04/01/23.
//

import UIKit
import Core

public class HomeRouter {
  func makeDetailView(game: GameDetailModel, screenshots: [Screenshot]) -> UIViewController {
    return GameBuilder.getView(module: .detail(game: game, screenshots: screenshots))
  }
}
