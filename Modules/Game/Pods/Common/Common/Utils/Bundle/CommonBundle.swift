//
//  CommonBundle.swift
//  Common
//
//  Created by Kevin Hardianto on 02/11/23.
//

import UIKit

public class CommonBundle: NSObject {
    public static func getIdentifier() -> String {
        let bundle = Bundle(for: CommonBundle.self)
        let identifier = bundle.bundleIdentifier
        return identifier ?? ""
    }
}
