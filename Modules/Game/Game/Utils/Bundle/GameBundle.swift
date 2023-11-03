//
//  GameBundle.swift
//  Game
//
//  Created by Kevin Hardianto on 03/11/23.
//

import UIKit

public class GameBundle: NSObject {
    public static func getIdentifier() -> String {
        let bundle = Bundle(for: GameBundle.self)
        let identifier = bundle.bundleIdentifier
        return identifier ?? ""
    }
}
