//
//  FavouriteRouter.swift
//  Catalog
//
//  Created by Kevin Hardianto on 04/01/23.
//

import UIKit

class FavouriteRouter {
  func makeDetailView(game: GameDetailModel) -> UIViewController {
    return GameBuilder.getView(module: .detail(game: game, screenshots: []))
  }
}
