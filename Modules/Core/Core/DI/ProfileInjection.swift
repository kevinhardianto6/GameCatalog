//
//  ProfileInjection.swift
//  Profile
//
//  Created by Kevin Hardianto on 25/10/23.
//

import UIKit

public class ProfileInjection: NSObject {
    public static func provideProfile() -> ProfileUseCase {
      let profileRepository = ProfileRepository.sharedInstance
      return ProfileInteractor(profileRepisotory: profileRepository)
    }
}
