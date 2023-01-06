//
//  SplashViewController.swift
//  Catalog
//
//  Created by Kevin Hardianto on 01/10/22.
//

import UIKit

class SplashViewController: UIViewController {
  override func viewDidLoad() {
    super.viewDidLoad()
    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
      self.requestHome()
    }
  }
  
  func requestHome() {
    let main = MainTabController()
    main.modalPresentationStyle = .fullScreen
    self.navigationController?.pushViewController(main, animated: true)
  }
}
