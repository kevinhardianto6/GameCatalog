//
//  ProfileRouter.swift
//  Catalog
//
//  Created by Kevin Hardianto on 04/01/23.
//

import UIKit

public class ProfileRouter {
  
  func makeEditProfileView() -> UIViewController {
    return ProfileBuilder.getView(module: .editProfile)
  }
  
}
