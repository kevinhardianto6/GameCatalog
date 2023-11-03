//
//  FavouriteViewController.swift
//  Catalog
//
//  Created by Kevin Hardianto on 11/10/22.
//

import UIKit
import RxSwift
import Core

class FavouriteViewController: BaseViewController {
  
  public var favouriteViewModel: FavouriteViewModel!
  
  @IBOutlet weak var collectionView: UICollectionView!
  @IBOutlet weak var btnDeleteAll: UIButton!
  
  private var favGames = [GameModel]()
  private var id: Int = 0
  
  private let disposeBag = DisposeBag()
  
  public init() {
      super.init(nibName: "FavouriteViewController", bundle: Bundle(identifier: GameBundle.getIdentifier()))
  }
  
  required init?(coder: NSCoder) {
      super.init(nibName: "FavouriteViewController", bundle: Bundle(identifier: GameBundle.getIdentifier()))
  }
  
  override public func viewDidLoad() {
    super.viewDidLoad()
    setupUI()
    setupBinding()
  }
  
  override public func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    setupData()
  }
  
  func setupUI() {
    collectionView.register(UINib(nibName: FavouriteCell.cellIdentifier, bundle: Bundle(for: FavouriteViewController.self)), forCellWithReuseIdentifier: FavouriteCell.cellIdentifier)
  }
  
  func setupBinding() {
    favouriteViewModel.success.subscribe(onNext: { games in
      if games.count > 0 {
        self.collectionView.backgroundView = nil
        self.btnDeleteAll.isEnabled = true
        self.favGames = games
        self.collectionView.reloadData()
      } else {
        self.showEmptyFavouriteGameState()
      }
    }).disposed(by: favouriteViewModel.disposeBag)
    
    favouriteViewModel.success.bind(to: collectionView.rx.items(cellIdentifier: FavouriteCell.cellIdentifier, cellType: FavouriteCell.self)) { (row, game, cell) in
      cell.update(with: game)
    }.disposed(by: favouriteViewModel.disposeBag)
    
    collectionView.rx.modelSelected(GameModel.self).subscribe(onNext: { game in
      self.favouriteViewModel.getDetailGame(gameId: game.id ?? 0)
    }).disposed(by: disposeBag)
    
    collectionView.rx.itemSelected.subscribe(onNext: { indexPath in
      self.collectionView.deselectItem(at: indexPath, animated: true)
    }).disposed(by: disposeBag)
    
    favouriteViewModel.deleted.subscribe(onNext: { _ in
      DispatchQueue.main.async {
        let alert = UIAlertController(title: "Successful", message: "Favourite Game has been cleared.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default) { _ in
          self.favouriteViewModel.getAllFavouriteGames()
        })
        self.present(alert, animated: true, completion: nil)
      }
    }).disposed(by: favouriteViewModel.disposeBag)
    
    favouriteViewModel.detail.subscribe(onNext: { game in
      let detail = self.favouriteViewModel.makeDetailView(game: game)
      self.navigationController?.pushViewController(detail, animated: true)
    }).disposed(by: favouriteViewModel.disposeBag)
    
    favouriteViewModel.error.subscribe(onNext: { _ in
      self.showAlert(title: "Attention", message: "Failed to Retrieve Data.")
    }).disposed(by: favouriteViewModel.disposeBag)
    
    btnDeleteAll.rx.tap
      .asObservable()
      .subscribe(onNext: { _ in
        let alert = UIAlertController(title: "Warning", message: "Do you want to delete all your favourite game?", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Yes", style: .default) { _ in
          self.favouriteViewModel.deleteAllFavouriteGames()
        })
        
        alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
      })
      .disposed(by: disposeBag)
  }
  
  func setupData() {
    favouriteViewModel.getAllFavouriteGames()
  }
  
  func showEmptyFavouriteGameState() {
    let rect = CGRect(x: 0,
                      y: 0,
                      width: self.collectionView.bounds.size.width,
                      height: self.collectionView.bounds.size.height)
    let noDataLabel: UILabel = UILabel(frame: rect)
    noDataLabel.text = "Your Favourite List Is Empty\nPlease Add First !"
    noDataLabel.font = UIFont(name: CoreFontEnum.interSemiBold, size: 16)
    noDataLabel.numberOfLines = 0
    noDataLabel.textAlignment = .center
    noDataLabel.textColor = UIColor.white
    noDataLabel.sizeToFit()
    
    self.collectionView.backgroundView = noDataLabel
    self.btnDeleteAll.isEnabled = false
  }
}
