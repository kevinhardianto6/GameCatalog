//
//  HomeCell.swift
//  Catalog
//
//  Created by Kevin Hardianto on 01/10/22.
//

import UIKit
import RxSwift

class HomeCell: UICollectionViewCell {
  
  @IBOutlet weak var containerDetail: UIView!
  @IBOutlet weak var imgBackground: UIImageView!
  @IBOutlet weak var labelTitle: UILabel!
  @IBOutlet weak var labelReleased: UILabel!
  @IBOutlet weak var labelRating: UILabel!
  @IBOutlet weak var labelGenre: UILabel!
  
  var disposeBag = DisposeBag()
  
  override func awakeFromNib() {
    super.awakeFromNib()
  }
  
  override func prepareForReuse() {
    disposeBag = DisposeBag()
  }
  
  func hideDetail() {
    containerDetail.isHidden = true
    labelTitle.isHidden = true
    labelReleased.isHidden = true
    labelRating.isHidden = true
    labelGenre.isHidden = true
  }
}
