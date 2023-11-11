//
//  FittedCollectionView.swift
//  Common
//
//  Created by Kevin Hardianto on 01/10/23.
//

import UIKit

/// You can use this view if you want to use `UICollectionView` inside `UIScrollView` with dynamic height.
public class FittedCollectionView: UICollectionView {
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        commonInit()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }

    private func commonInit() {
        isScrollEnabled = true
    }

    public override var contentSize: CGSize {
        didSet {
            invalidateIntrinsicContentSize()
        }
    }

    public override func reloadData() {
        super.reloadData()
        self.invalidateIntrinsicContentSize()
    }

    public override var intrinsicContentSize: CGSize {
        return contentSize
    }
}
