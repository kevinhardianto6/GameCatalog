//
//  FittedTableView.swift
//  Common
//
//  Created by Kevin Hardianto on 01/10/23.
//

import UIKit

/// You can use this view if you want to use `UITableView` inside `UIScrollView` with dynamic height.
public class FittedTableView: UITableView {
    public override var contentSize:CGSize {
      didSet {
          invalidateIntrinsicContentSize()
      }
  }

    public override var intrinsicContentSize: CGSize {
      layoutIfNeeded()
      return CGSize(width: UIView.noIntrinsicMetric, height: contentSize.height)
  }
}
