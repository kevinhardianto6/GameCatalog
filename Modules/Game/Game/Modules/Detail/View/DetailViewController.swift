//
//  DetailViewController.swift
//  Catalog
//
//  Created by Kevin Hardianto on 01/10/22.
//

import UIKit
import RxSwift
import Core

public class DetailViewController: BaseViewController {
  
  public var detailViewModel: DetailViewModel!
  
  @IBOutlet weak var btnBack: UIButton!
  
  @IBOutlet weak var imgBackground: UIImageView!
  @IBOutlet weak var labelTitle: UILabel!
  @IBOutlet weak var labelReleased: UILabel!
  @IBOutlet weak var labelRating: UILabel!
  @IBOutlet weak var labelGenre: UILabel!
  @IBOutlet weak var labelPlatform: UILabel!
  @IBOutlet weak var labelDescription: UILabel!
  @IBOutlet weak var labelGamePreview: UILabel!
  @IBOutlet weak var collectionView: UICollectionView!
  @IBOutlet weak var btnFavourite: UIButton!
  
  private var isFavourite: Bool = false
  private var game: GameDetailModel
  private var screenshots = [Screenshot]()
  
  private let disposeBag = DisposeBag()
  
  public init(game: GameDetailModel, screenshots: [Screenshot]) {
    self.game = game
    self.screenshots = screenshots
    
    super.init(nibName: "DetailViewController", bundle: Bundle(identifier: GameBundle.getIdentifier()))
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
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
    btnFavourite.layer.cornerRadius = btnFavourite.frame.height/2
    
    collectionView.register(UINib(nibName: HomeCell.cellIdentifier, bundle: Bundle(identifier: GameBundle.getIdentifier())), forCellWithReuseIdentifier: HomeCell.cellIdentifier)
  }
  
  func setupBinding() {
    detailViewModel.isFavourite.subscribe(onNext: { isFavourite in
      if isFavourite {
        self.btnFavourite.setImage(UIImage(named: "favourite_remove",in: Bundle(for: DetailViewController.self),compatibleWith: nil), for: .normal)
      } else {
        self.btnFavourite.setImage(UIImage(named: "favourite_add",in: Bundle(for: DetailViewController.self),compatibleWith: nil), for: .normal)
      }
      
      self.isFavourite = isFavourite
    }).disposed(by: detailViewModel.disposeBag)
    
    Observable.just(game).subscribe(onNext: { game in
      self.setupGameData(game: game)
    }).disposed(by: disposeBag)
    
    Observable.just(screenshots).subscribe(onNext: { screenshots in
      self.setupScreenshotData(screenshots: screenshots)
    }).disposed(by: disposeBag)
    
    Observable.just(screenshots)
      .bind(to: collectionView.rx.items(cellIdentifier: HomeCell.cellIdentifier, cellType: HomeCell.self)) { (row, screenshot, cell) in
        cell.update(with: screenshot)
      }.disposed(by: disposeBag)
    
    btnBack.rx.tap
      .asObservable()
      .subscribe(onNext: { _ in
        self.navigationController?.popViewController(animated: true)
      })
      .disposed(by: disposeBag)
    
    btnFavourite.rx.tap
      .asObservable()
      .subscribe(onNext: { _ in
        if self.isFavourite {
          self.btnFavourite.setImage(UIImage(named: "favourite_add",in: Bundle(for: DetailViewController.self),compatibleWith: nil), for: .normal)
          self.isFavourite = false
          
          self.detailViewModel.deleteFavouriteGame(gameId: self.game.id ?? 0)
        } else {
          self.btnFavourite.setImage(UIImage(named: "favourite_remove",in: Bundle(for: DetailViewController.self),compatibleWith: nil), for: .normal)
          self.isFavourite = true
          let gameModel = GameModel(
            id: self.game.id,
            name: self.game.name,
            released: self.game.released,
            backgroundImage: self.game.backgroundImage,
            rating: self.game.rating,
            ratingTop: self.game.ratingTop,
            genres: nil,
            shortScreenshots: nil
          )
          
          self.detailViewModel?.addFavouriteGame(game: gameModel)
        }
      })
      .disposed(by: disposeBag)
    
    detailViewModel.loading.subscribe(onNext: { shimmer in
      if shimmer {
        self.showLoading(view: self.view)
      } else {
        self.removeLoading()
      }
    }).disposed(by: detailViewModel.disposeBag)
    
    detailViewModel.error.subscribe(onNext: { _ in
      self.showAlert(title: "Attention", message: "Failed to Retrieve Data.")
    }).disposed(by: detailViewModel.disposeBag)
    
    detailViewModel.add.subscribe(onNext: { _ in
      DispatchQueue.main.async {
        let alert = UIAlertController(title: "Successful", message: "Game added to favourite.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        self.present(alert, animated: true, completion: nil)
      }
    }).disposed(by: detailViewModel.disposeBag)
    
    detailViewModel.remove.subscribe(onNext: { _ in
      DispatchQueue.main.async {
        let alert = UIAlertController(title: "Successful", message: "Game has been removed from favourite.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        self.present(alert, animated: true, completion: nil)
      }
    }).disposed(by: detailViewModel.disposeBag)
  }
  
  func setupData() {
    detailViewModel.checkGameIsFavourite(gameId: game.id ?? 0)
  }
  
  func setupGameData(game: GameDetailModel?) {
    self.labelTitle.text = game?.name ?? ""
    self.labelReleased.text = "Release: \(game?.released ?? "")"
    self.labelRating.text = "Rate: \(game?.rating ?? 0) / \(game?.ratingTop ?? 0)"
    self.labelGenre.text = "Genre: " +  Genre.getGenresToString(genres: game?.genres ?? [])
    self.labelPlatform.text =  Platform.getPlatformsToString(platforms: game?.platforms ?? [])
    
    let filteredDescription  = game?.description?.replacingOccurrences(of: "<br />|<p>|</p>|<br>|<br/>", with: "", options: .regularExpression)
    self.labelDescription.text = filteredDescription
    
    if let urls = URL(string: game?.backgroundImage ?? "") {
      self.imgBackground.kf.setImage(with: urls)
    }
  }
  
  func setupScreenshotData(screenshots: [Screenshot]) {
    if screenshots.count > 0 {
      self.labelGamePreview.isHidden = false
      self.collectionView.isHidden = false
    } else {
      self.labelGamePreview.isHidden = true
      self.collectionView.isHidden = true
    }
  }
}

