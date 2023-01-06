//
//  ProfileInteractor.swift
//  Catalog
//
//  Created by Kevin Hardianto on 03/01/23.
//

import UIKit
import RxSwift

protocol ProfileUseCase {
  func getProfile() -> Observable<String>
  func setProfile(name: String) -> Observable<Bool>
}

class ProfileInteractor: ProfileUseCase {
  
  private let repository: ProfileRepositoryProtocol
  
  required init(repository: ProfileRepositoryProtocol) {
    self.repository = repository
  }
  
  func getProfile() -> Observable<String> {
    return repository.getProfile()
  }
  
  func setProfile(name: String) -> Observable<Bool> {
    return repository.setProfile(name: name)
  }
}
