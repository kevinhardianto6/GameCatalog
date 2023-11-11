//
//  ProfileProvider.swift
//  Catalog
//
//  Created by Kevin Hardianto on 03/01/23.
//

import UIKit
import RxSwift

protocol ProfileProviderProtocol {
  func getProfile() -> Observable<String>
  func setProfile(name: String) -> Observable<Bool>
}

final class ProfileProvider: NSObject {
  static let sharedInstance = ProfileProvider()
}

extension ProfileProvider: ProfileProviderProtocol {
  func getProfile() -> Observable<String> {
    return Observable.create { observer in
      if let name = UserDefaults.standard.string(forKey: "name") {
        observer.onNext(name)
      } else {
        observer.onNext("Kevin Hardianto")
      }
      return Disposables.create()
    }
  }
  
  func setProfile(name: String) -> Observable<Bool> {
    return Observable.create { observer in
      UserDefaults.standard.set(name, forKey: "name")
      observer.onNext(true)
      
      return Disposables.create()
    }
  }
}
