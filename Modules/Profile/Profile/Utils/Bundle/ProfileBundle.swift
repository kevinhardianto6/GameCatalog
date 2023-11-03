//
//  ProfileBundle.swift
//  Profile
//
//  Created by Kevin Hardianto on 03/11/23.
//

import UIKit

public class ProfileBundle: NSObject {
    public static func getIdentifier() -> String {
        let bundle = Bundle(for: ProfileBundle.self)
        let identifier = bundle.bundleIdentifier
        return identifier ?? ""
    }
}
