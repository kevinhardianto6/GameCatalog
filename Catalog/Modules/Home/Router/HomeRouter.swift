//
//  HomeRouter.swift
//  Catalog
//
//  Created by Kevin Hardianto on 04/01/23.
//

import UIKit

class HomeRouter {
  
  func makeDetailView(game: GameDetailModel, screenshots: [Screenshot]) -> UIViewController {
    let detail = DetailViewController()
    let detailUseCase = Injection.init().provideDetail()
    let detailViewModel = DetailViewModel(detailUseCase: detailUseCase)
    detail.setViewModel(viewModel: detailViewModel)
    detail.game = game
    detail.screenshots = screenshots
    detail.modalPresentationStyle = .fullScreen
    return detail
  }
  
}
