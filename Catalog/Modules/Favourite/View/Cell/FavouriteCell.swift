//
//  FavouriteCell.swift
//  Catalog
//
//  Created by Kevin Hardianto on 11/10/22.
//

import UIKit

class FavouriteCell: UICollectionViewCell {
  
  @IBOutlet weak var containerDetail: UIView!
  @IBOutlet weak var imgBackground: UIImageView!
  @IBOutlet weak var labelTitle: UILabel!
  @IBOutlet weak var labelReleased: UILabel!
  @IBOutlet weak var labelRating: UILabel!
  
  override func awakeFromNib() {
    super.awakeFromNib()
  }
}
