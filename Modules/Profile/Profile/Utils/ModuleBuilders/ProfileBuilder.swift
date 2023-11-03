//
//  ProfileBuilder.swift
//  Catalog
//
//  Created by Kevin Hardianto on 03/10/23.
//

import UIKit

public class ProfileBuilder: NSObject {
  public class func getView(module: ProfileModuleEnum) -> UIViewController {
    switch module {
    case .profile:
      let profile = ProfileViewController()
      let profileUseCase = ProfileInjection.provideProfile()
      let profileViewModel = ProfileViewModel(profileUseCase: profileUseCase)
      profile.profileViewModel = profileViewModel
      return profile
    case .editProfile:
      let editProfile = EditProfileViewController()
      let editProfileUseCase = ProfileInjection.provideProfile()
      let editProfileViewModel = EditProfileViewModel(profileUseCase: editProfileUseCase)
      editProfile.editProfileViewModel = editProfileViewModel
      return editProfile
    }
  }
}
