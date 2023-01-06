//
//  ProfileRouter.swift
//  Catalog
//
//  Created by Kevin Hardianto on 04/01/23.
//

import UIKit

class ProfileRouter {
  
  func makeEditProfileView() -> UIViewController {
    let editProfile = EditProfileViewController()
    let editProfileUseCase = Injection.init().provideProfile()
    let editProfileViewModel = EditProfileViewModel(profileUseCase: editProfileUseCase)
    editProfile.setViewModel(viewModel: editProfileViewModel)
    editProfile.modalPresentationStyle = .fullScreen
    return editProfile
  }
  
}
