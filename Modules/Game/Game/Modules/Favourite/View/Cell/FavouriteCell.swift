//
//  FavouriteCell.swift
//  Catalog
//
//  Created by Kevin Hardianto on 11/10/22.
//

import UIKit
import RxSwift

public class FavouriteCell: UICollectionViewCell {
  @IBOutlet weak var imgBackground: UIImageView!
  
  public static let cellIdentifier = "FavouriteCell"
  
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
    
    self.layer.cornerRadius = 16
  }
}
