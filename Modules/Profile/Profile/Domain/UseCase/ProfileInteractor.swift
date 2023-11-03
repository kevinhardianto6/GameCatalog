//
//  ProfileInteractor.swift
//  Catalog
//
//  Created by Kevin Hardianto on 03/01/23.
//

import UIKit
import RxSwift

public protocol ProfileUseCase {
  func getProfile() -> Observable<String>
  func setProfile(name: String) -> Observable<Bool>
}

public class ProfileInteractor: ProfileUseCase {
  private let profileRepisotory: ProfileRepositoryProtocol
  
  required init(profileRepisotory: ProfileRepositoryProtocol) {
    self.profileRepisotory = profileRepisotory
  }
  
    public func getProfile() -> Observable<String> {
    return profileRepisotory.getProfile()
  }
  
    public func setProfile(name: String) -> Observable<Bool> {
    return profileRepisotory.setProfile(name: name)
  }
}
