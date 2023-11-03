//
//  SplashViewController.swift
//  Catalog
//
//  Created by Kevin Hardianto on 01/10/22.
//

import UIKit
import AVFoundation

class SplashViewController: UIViewController {
  private var player: AVAudioPlayer?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupMusic()
    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
      self.navigationController?.pushViewController(MainBuilder.getView(module: .main), animated: true)
    }
  }
  
  func setupMusic() {
    guard let url = Bundle(for: SplashViewController.self).url(
      forResource: "Imagine-dragon-enemy",
      withExtension: "mp3"
    ) else {
      return
    }
    
    do {
      try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
      
      player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)
    } catch let error {
      print(error.localizedDescription)
    }
    
    player?.numberOfLoops = -1
    player?.play()
  }
}
