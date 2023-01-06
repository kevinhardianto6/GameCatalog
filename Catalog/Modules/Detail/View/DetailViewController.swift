//
//  DetailViewController.swift
//  Catalog
//
//  Created by Kevin Hardianto on 01/10/22.
//

import UIKit
import RxSwift

class DetailViewController: BaseViewController {
  
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
  
  private var detailViewModel: DetailViewModelProtocol?
  
  private let cellIdentifier = "HomeCell"
  
  private var isFavourite: Bool = false
  var game: GameDetailModel?
  var screenshots = [Screenshot]()
  
  private let disposeBag = DisposeBag()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupUI()
    setupBinding()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    detailViewModel?.checkGameIsFavourite(gameId: game?.id ?? 0)
  }
  
  func setViewModel(viewModel: DetailViewModelProtocol) {
    self.detailViewModel = viewModel
  }
  
  func setupUI() {
    btnFavourite.layer.cornerRadius = btnFavourite.frame.height/2
    
    collectionView.register(UINib(nibName: cellIdentifier, bundle: nil), forCellWithReuseIdentifier: cellIdentifier)
  }
  
  func setupBinding() {
    detailViewModel?.isFavourite.subscribe(onNext: { isFavourite in
      if isFavourite {
        self.btnFavourite.setImage(UIImage(named: "favourite_remove"), for: .normal)
      } else {
        self.btnFavourite.setImage(UIImage(named: "favourite_add"), for: .normal)
      }
      
      self.isFavourite = isFavourite
    }).disposed(by: detailViewModel?.disposeBag ?? disposeBag)
    
    Observable.just(game).subscribe(onNext: { game in
      self.labelTitle.text = game?.name
      self.labelReleased.text = "Release: \(game?.released ?? "")"
      self.labelRating.text = "Rate: \(game?.rating ?? 0) / \(game?.ratingTop ?? 0)"
      self.labelGenre.text = "Genre: " +  self.getGenresToString(genres: game?.genres ?? [])
      self.labelPlatform.text =  self.getPlatformsToString(platforms: game?.platforms ?? [])
      
      let filteredDescription  = game?.description?.replacingOccurrences(of: "<br />|<p>|</p>|<br>|<br/>", with: "", options: .regularExpression)
      self.labelDescription.text = filteredDescription
      
      if let urls = URL(string: game?.backgroundImage ?? "") {
        self.imgBackground.kf.setImage(with: urls)
      }
    }).disposed(by: disposeBag)
    
    Observable.just(screenshots).subscribe(onNext: { screenshots in
      if screenshots.count > 0 {
        self.labelGamePreview.isHidden = false
        self.collectionView.isHidden = false
      } else {
        self.labelGamePreview.isHidden = true
        self.collectionView.isHidden = true
      }
    }).disposed(by: disposeBag)
    
    Observable.just(screenshots)
      .bind(to: collectionView.rx.items(cellIdentifier: cellIdentifier, cellType: HomeCell.self)) { (row, screenshot, cell) in
        
        if let urls = URL(string: screenshot.image ?? "") {
          cell.imgBackground.kf.setImage(with: urls)
        }
        
        cell.hideDetail()
        cell.layer.cornerRadius = 8
        
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
          self.btnFavourite.setImage(UIImage(named: "favourite_add"), for: .normal)
          self.isFavourite = false
          
          self.detailViewModel?.deleteFavouriteGame(gameId: self.game?.id ?? 0)
        } else {
          self.btnFavourite.setImage(UIImage(named: "favourite_remove"), for: .normal)
          self.isFavourite = true
          
          let gameModel = GameModel(
            id: self.game?.id,
            name: self.game?.name,
            released: self.game?.released,
            backgroundImage: self.game?.backgroundImage,
            rating: self.game?.rating,
            ratingTop: self.game?.ratingTop,
            genres: nil,
            shortScreenshots: nil
          )
          
          self.detailViewModel?.addFavouriteGame(game: gameModel)
        }
      })
      .disposed(by: disposeBag)
    
    detailViewModel?.loading.subscribe(onNext: { shimmer in
      if shimmer {
        self.showLoading()
      } else {
        self.removeLoading()
      }
    }).disposed(by: detailViewModel?.disposeBag ?? disposeBag)
    
    detailViewModel?.error.subscribe(onNext: { _ in
      self.showAlert(title: "Attention", message: "Failed to Retrieve Data.")
    }).disposed(by: detailViewModel?.disposeBag ?? disposeBag)
    
    detailViewModel?.add.subscribe(onNext: { _ in
      DispatchQueue.main.async {
        let alert = UIAlertController(title: "Successful", message: "Game added to favourite.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        self.present(alert, animated: true, completion: nil)
      }
    }).disposed(by: detailViewModel?.disposeBag ?? disposeBag)
    
    detailViewModel?.remove.subscribe(onNext: { _ in
      DispatchQueue.main.async {
        let alert = UIAlertController(title: "Successful", message: "Game has been removed from favourite.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        self.present(alert, animated: true, completion: nil)
      }
    }).disposed(by: detailViewModel?.disposeBag ?? disposeBag)
  }
}

