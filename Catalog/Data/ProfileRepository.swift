//
//  ProfileRepository.swift
//  Catalog
//
//  Created by Kevin Hardianto on 03/01/23.
//

import UIKit
import RxSwift

protocol ProfileRepositoryProtocol {
  func getProfile() -> Observable<String>
  func setProfile(name: String) -> Observable<Bool>
}

final class ProfileRepository: NSObject {
  
  typealias ProfileInstance = (ProfileProvider) -> ProfileRepository
  
  fileprivate let profileProvider: ProfileProvider
  
  private init(profileProvider: ProfileProvider) {
    self.profileProvider = profileProvider
  }
  
  static let sharedInstance: ProfileInstance = { profileProvider in
    return ProfileRepository(profileProvider: profileProvider)
  }
}

extension ProfileRepository: ProfileRepositoryProtocol {
  func getProfile() -> Observable<String> {
    return self.profileProvider.getProfile()
  }
  
  func setProfile(name: String) -> Observable<Bool> {
    return self.profileProvider.setProfile(name: name)
  }
}
