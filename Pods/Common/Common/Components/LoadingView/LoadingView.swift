//
//  LoadingView.swift
//  Common
//
//  Created by Kevin Hardianto on 29/10/23.
//

import UIKit

public class LoadingView: UIView {

  @IBOutlet var contentView: UIView!
  @IBOutlet public weak var indicator: UIActivityIndicatorView!
  
  override public init(frame: CGRect) {
    super.init(frame: frame)
    setupNib()
  }
  
  required public init?(coder: NSCoder) {
    super.init(coder: coder)
    setupNib()
  }
  
  private func setupNib() {
    let frameworkBundle = Bundle(for: LoadingView.self)
    frameworkBundle.loadNibNamed("LoadingView", owner: self, options: nil)
    addSubview(contentView)
    contentView.frame = self.bounds
    contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
  }

}
