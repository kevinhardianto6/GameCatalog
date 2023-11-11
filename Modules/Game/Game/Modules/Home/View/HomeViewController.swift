//
//  HomeViewController.swift
//  Catalog
//
//  Created by Kevin Hardianto on 01/10/22.
//

import UIKit
import RxSwift
import Core
import Common

public class HomeViewController: BaseViewController {
  
  public var homeViewModel: HomeViewModel!
  
  @IBOutlet weak var collectionView: UICollectionView!
  @IBOutlet weak var containerSearch: UIView!
  @IBOutlet weak var textfieldSearch: UITextField!
  @IBOutlet weak var btnClearText: UIButton!
  
  private var games = [GameModel]()
  private var screenshots = [Screenshot]()
  
  private let disposeBag = DisposeBag()
  
  public init() {
    super.init(nibName: "HomeViewController", bundle: Bundle(identifier: GameBundle.getIdentifier()))
  }
  
  required init?(coder: NSCoder) {
    super.init(nibName: "HomeViewController", bundle: Bundle(identifier: GameBundle.getIdentifier()))
  }
  
  override public func viewDidLoad() {
    super.viewDidLoad()
    setupUI()
    setupBinding()
  }
  
  override public func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    self.navigationController?.isNavigationBarHidden = true
    setupData()
  }
  
  func setupUI() {
    containerSearch.layer.cornerRadius = 20
    
    textfieldSearch.attributedPlaceholder = NSAttributedString(
      string: "Search by name",
      attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14)]
    )
    
    btnClearText.isHidden = true
    
    collectionView.register(UINib(nibName: HomeCell.cellIdentifier, bundle: Bundle(for: HomeViewController.self)), forCellWithReuseIdentifier: HomeCell.cellIdentifier)
  }
  
  func setupBinding() {
    homeViewModel.games.subscribe(onNext: { games in
      if games.count > 0 {
        self.collectionView.isHidden = false
        self.collectionView.backgroundView = nil
        self.games = games
        self.collectionView.reloadData()
      } else {
        self.showEmptyGameState()
      }
    }).disposed(by: homeViewModel.disposeBag)
    
    homeViewModel.games.bind(to: collectionView.rx.items(cellIdentifier: HomeCell.cellIdentifier, cellType: HomeCell.self)) { (row, game, cell) in
      cell.update(with: game)
    }.disposed(by: homeViewModel.disposeBag)
    
    collectionView.rx.modelSelected(GameModel.self).subscribe(onNext: { game in
      self.screenshots = game.shortScreenshots ?? [Screenshot]()
      self.homeViewModel?.getDetailGame(gameId: game.id ?? 0)
    }).disposed(by: disposeBag)
    
    collectionView.rx.itemSelected.subscribe(onNext: { indexPath in
      self.collectionView.deselectItem(at: indexPath, animated: true)
    }).disposed(by: disposeBag)
    
    homeViewModel.detail.subscribe(onNext: { game in
      let detail = self.homeViewModel.makeDetailView(game: game, screenshots: self.screenshots)
      self.navigationController?.pushViewController(detail, animated: true)
    }).disposed(by: homeViewModel.disposeBag)
    
    textfieldSearch.rx.controlEvent([.editingChanged])
      .asObservable()
      .subscribe(onNext: { _ in
        let text = self.textfieldSearch.text
        if text != "" && text != nil {
          self.btnClearText.isHidden = false
        } else {
          self.btnClearText.isHidden = true
        }
      })
      .disposed(by: disposeBag)
    
    textfieldSearch.rx.controlEvent([.editingDidEnd])
      .asObservable()
      .subscribe(onNext: { _ in
        let text = self.textfieldSearch.text
        if text != "" && text != nil {
          self.homeViewModel.getSearchGame(games: self.games, query: text ?? "")
        } else {
          self.homeViewModel.getAllGames()
        }
      })
      .disposed(by: disposeBag)
    
    textfieldSearch.rx.controlEvent([.editingDidEndOnExit])
      .asObservable()
      .subscribe(onNext: { _ in
        self.textfieldSearch.resignFirstResponder()
      })
      .disposed(by: disposeBag)
    
    btnClearText.rx.tap
      .asObservable()
      .subscribe(onNext: { _ in
        self.textfieldSearch.text = ""
        self.btnClearText.isHidden = true
        self.homeViewModel.getAllGames()
      })
      .disposed(by: disposeBag)
    
    homeViewModel.error.subscribe(onNext: { _ in
      self.showAlert(title: "Attention", message: "Failed to Retrieve Data")
    }).disposed(by: homeViewModel.disposeBag)
    
    homeViewModel.loading.subscribe(onNext: { shimmer in
      if shimmer {
        self.showLoading(view: self.collectionView)
      } else {
        self.removeLoading()
      }
    }).disposed(by: homeViewModel.disposeBag)
  }
  
  func setupData() {
    collectionView.isHidden = true
    textfieldSearch.text = ""
    homeViewModel.getAllGames()
  }
  
  func showEmptyGameState() {
    let rect = CGRect(x: 0,
                      y: 0,
                      width: self.collectionView.bounds.size.width,
                      height: self.collectionView.bounds.size.height)
    let noDataLabel: UILabel = UILabel(frame: rect)
    noDataLabel.text = "Game Not Found !"
    noDataLabel.font = UIFont(name: CommonFontEnum.interSemiBold, size: 16)
    noDataLabel.textAlignment = .center
    noDataLabel.textColor = UIColor.white
    noDataLabel.sizeToFit()
    
    self.collectionView.backgroundView = noDataLabel
  }
}
