//
//  BaseViewController.swift
//  Catalog
//
//  Created by Kevin Hardianto on 01/10/22.
//

import UIKit

class BaseViewController: UIViewController {
  
  var loading: LoadingView?
  
  override var preferredStatusBarStyle: UIStatusBarStyle {
    UIStatusBarStyle.lightContent
  }
  
  func showAlert(title: String?, message: String?) {
    let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
    let ok = UIAlertAction(title: "Ok", style: .default) { _ in
      alert.dismiss(animated: true, completion: nil)
    }
    alert.addAction(ok)
    self.present(alert, animated: true, completion: nil)
  }
  
  func getGenresToString(genres: [Genre]) -> String {
    var stringGenre = ""
    for (index, genre) in genres.enumerated() {
      if index != genres.endIndex-1 {
        stringGenre.append(String(format: "%@, ", genre.name ?? ""))
      } else {
        stringGenre.append(String(format: "%@", genre.name ?? ""))
      }
    }
    
    return stringGenre
  }
  
  func getPlatformsToString(platforms: [PlatformData]) -> String {
    var stringPlatform = ""
    for (index, platform) in platforms.enumerated() {
      if index != platforms.endIndex-1 {
        stringPlatform.append(String(format: "%@, ", platform.platform?.name ?? ""))
      } else {
        stringPlatform.append(String(format: "%@", platform.platform?.name ?? ""))
      }
    }
    
    return stringPlatform
  }
  
  func showLoading() {
    loading = LoadingView()
    self.view.addSubview(loading!)
    loading?.translatesAutoresizingMaskIntoConstraints = false
    loading?.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
    loading?.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
    loading?.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
    loading?.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
    loading?.indicator.startAnimating()
  }
  
  func removeLoading() {
    loading?.indicator.stopAnimating()
    loading?.removeFromSuperview()
  }
}
