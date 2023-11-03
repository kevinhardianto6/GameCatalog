//
//  CoreBundle.swift
//  Core
//
//  Created by Kevin Hardianto on 02/11/23.
//

import UIKit

public class CoreBundle: NSObject {
    public static func getIdentifier() -> String {
        let bundle = Bundle(for: CoreBundle.self)
        let identifier = bundle.bundleIdentifier
        return identifier ?? ""
    }
}
