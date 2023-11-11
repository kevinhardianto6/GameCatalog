//
//  ProfileBuilder.swift
//  Profile
//
//  Created by Kevin Hardianto on 12/11/23.
//

import UIKit
import Core

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
