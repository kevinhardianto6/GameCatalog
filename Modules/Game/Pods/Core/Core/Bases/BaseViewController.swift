//
//  BaseViewController.swift
//  Catalog
//
//  Created by Kevin Hardianto on 01/10/22.
//

import UIKit

open class BaseViewController: UIViewController {
  
  public var loading: LoadingView?
  
  open override var preferredStatusBarStyle: UIStatusBarStyle {
    UIStatusBarStyle.lightContent
  }
  
  public func showAlert(title: String?, message: String?) {
    let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
    let ok = UIAlertAction(title: "Ok", style: .default) { _ in
      alert.dismiss(animated: true, completion: nil)
    }
    alert.addAction(ok)
    self.present(alert, animated: true, completion: nil)
  }
  
  public func showLoading(view: UIView) {
    guard loading == nil else { return }
    
    loading = LoadingView()
    self.view.addSubview(loading!)
    loading?.translatesAutoresizingMaskIntoConstraints = false
    loading?.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
    loading?.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    loading?.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
    loading?.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    loading?.indicator.startAnimating()
  }
  
  public func removeLoading() {
    loading?.indicator.stopAnimating()
    loading?.removeFromSuperview()
    loading = nil
  }
}
