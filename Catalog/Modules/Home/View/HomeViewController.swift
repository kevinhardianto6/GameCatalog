//
//  HomeViewController.swift
//  Catalog
//
//  Created by Kevin Hardianto on 01/10/22.
//

import UIKit
import Kingfisher
import AVFoundation
import RxSwift

class HomeViewController: BaseViewController {
  
  @IBOutlet weak var collectionView: UICollectionView!
  @IBOutlet weak var containerSearch: UIView!
  @IBOutlet weak var textfieldSearch: UITextField!
  @IBOutlet weak var btnClearText: UIButton!
  
  private var homeViewModel: HomeViewModelProtocol?
  
  private let cellIdentifier = "HomeCell"
  
  private var games = [GameModel]()
  private var screenshots = [Screenshot]()
  
  private let disposeBag = DisposeBag()
  
  private var player: AVAudioPlayer?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupUI()
    setupBinding()
    setupMusic()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    self.navigationController?.isNavigationBarHidden = true
    homeViewModel?.getAllGames()
  }
  
  func setViewModel(viewModel: HomeViewModelProtocol) {
    self.homeViewModel = viewModel
  }
  
  func setupUI() {
    containerSearch.layer.cornerRadius = 20
    
    textfieldSearch.attributedPlaceholder = NSAttributedString(
      string: "Search by name",
      attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14)]
    )
    
    btnClearText.isHidden = true
    
    collectionView.register(UINib(nibName: cellIdentifier, bundle: nil), forCellWithReuseIdentifier: cellIdentifier)
  }
  
  func setupBinding() {
    homeViewModel?.games.subscribe(onNext: { games in
      if games.count > 0 {
        self.collectionView.backgroundView = nil
        self.games = games
        self.collectionView.reloadData()
      } else {
        self.showEmptyGameState()
      }
    }).disposed(by: homeViewModel?.disposeBag ?? disposeBag)
    
    homeViewModel?.games.bind(to: collectionView.rx.items(cellIdentifier: cellIdentifier, cellType: HomeCell.self)) { (row, game, cell) in
      
      if let urls = URL(string: game.backgroundImage ?? "") {
        cell.imgBackground.kf.setImage(with: urls)
      }
      
      cell.labelTitle.text = game.name
      cell.labelReleased.text = "Release: \(game.released ?? "")"
      cell.labelRating.text = "Rate: \(game.rating ?? 0) / \(game.ratingTop ?? 0)"
      cell.labelGenre.text = "Genre: " + self.getGenresToString(genres: game.genres ?? [])
      
      cell.layer.cornerRadius = 16
      
    }.disposed(by: homeViewModel?.disposeBag ?? disposeBag)
    
    collectionView.rx.modelSelected(GameModel.self).subscribe(onNext: { game in
      self.screenshots = game.shortScreenshots ?? [Screenshot]()
      self.homeViewModel?.getDetailGame(gameId: game.id ?? 0)
    }).disposed(by: disposeBag)
    
    collectionView.rx.itemSelected.subscribe(onNext: { indexPath in
      self.collectionView.deselectItem(at: indexPath, animated: true)
    }).disposed(by: disposeBag)
    
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
          self.homeViewModel?.getSearchGame(games: self.games, query: text ?? "")
        } else {
          self.homeViewModel?.getAllGames()
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
        self.homeViewModel?.getAllGames()
      })
      .disposed(by: disposeBag)
    
    homeViewModel?.detail.subscribe(onNext: { game in
      if let detail = self.homeViewModel?.makeDetailView(game: game, screenshots: self.screenshots) {
        self.navigationController?.pushViewController(detail, animated: true)
      }
    }).disposed(by: homeViewModel?.disposeBag ?? disposeBag)
    
    homeViewModel?.error.subscribe(onNext: { _ in
      self.showAlert(title: "Attention", message: "Failed to Retrieve Data")
    }).disposed(by: homeViewModel?.disposeBag ?? disposeBag)
    
    homeViewModel?.loading.subscribe(onNext: { shimmer in
      if shimmer {
        self.showLoading()
      } else {
        self.removeLoading()
      }
    }).disposed(by: homeViewModel?.disposeBag ?? disposeBag)
  }
  
  func setupMusic() {
    guard let url = Bundle.main.url(
      forResource: "Imagine-dragon-enemy",
      withExtension: "mp3"
    ) else {
      return
    }
    
    do {
      try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
      
      player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)
    } catch let error {
      print(error.localizedDescription)
    }
    
    player?.numberOfLoops = -1
    player?.play()
  }
  
  func showEmptyGameState() {
    let rect = CGRect(x: 0,
                      y: 0,
                      width: self.collectionView.bounds.size.width,
                      height: self.collectionView.bounds.size.height)
    let noDataLabel: UILabel = UILabel(frame: rect)
    noDataLabel.text = "Game Not Found !"
    noDataLabel.textAlignment = .center
    noDataLabel.textColor = UIColor.white
    noDataLabel.sizeToFit()
    
    self.collectionView.backgroundView = noDataLabel
  }
}
