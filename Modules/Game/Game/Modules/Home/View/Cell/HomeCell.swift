//
//  HomeCell.swift
//  Catalog
//
//  Created by Kevin Hardianto on 01/10/22.
//

import UIKit
import Kingfisher
import RxSwift
import Core

public class HomeCell: UICollectionViewCell {
  
  @IBOutlet weak var containerDetail: UIView!
  @IBOutlet weak var imgBackground: UIImageView!
  @IBOutlet weak var labelTitle: UILabel!
  @IBOutlet weak var labelReleased: UILabel!
  @IBOutlet weak var labelRating: UILabel!
  @IBOutlet weak var labelGenre: UILabel!
  
  public static let cellIdentifier = "HomeCell"
  
  var disposeBag = DisposeBag()
  
  override public func awakeFromNib() {
    super.awakeFromNib()
  }
  
  override public func prepareForReuse() {
    super.prepareForReuse()
    disposeBag = DisposeBag()
  }
  
  public func update(with item: GameModel) {
    if let urls = URL(string: item.backgroundImage ?? "") {
      imgBackground.kf.setImage(with: urls)
    }
    
    labelTitle.text = item.name
    labelReleased.text = "Release: \(item.released ?? "")"
    labelRating.text = "Rate: \(item.rating ?? 0) / \(item.ratingTop ?? 0)"
    labelGenre.text = "Genre: " + Genre.getGenresToString(genres: item.genres ?? [])
    
    self.layer.cornerRadius = 16
  }
  
  public func update(with item: Screenshot) {
    if let urls = URL(string: item.image ?? "") {
      imgBackground.kf.setImage(with: urls)
    }
    
    self.layer.cornerRadius = 8
    self.hideDetail()
  }
  
  private func hideDetail() {
    containerDetail.isHidden = true
    labelTitle.isHidden = true
    labelReleased.isHidden = true
    labelRating.isHidden = true
    labelGenre.isHidden = true
  }
}
