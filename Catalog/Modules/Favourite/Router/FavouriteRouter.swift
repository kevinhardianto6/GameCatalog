//
//  FavouriteRouter.swift
//  Catalog
//
//  Created by Kevin Hardianto on 04/01/23.
//

import UIKit

class FavouriteRouter {
  
  func makeDetailView(game: GameDetailModel) -> UIViewController {
    let detail = DetailViewController()
    let detailUseCase = Injection.init().provideDetail()
    let detailViewModel = DetailViewModel(detailUseCase: detailUseCase)
    detail.setViewModel(viewModel: detailViewModel)
    detail.game = game
    detail.modalPresentationStyle = .fullScreen
    return detail
  }
  
}
