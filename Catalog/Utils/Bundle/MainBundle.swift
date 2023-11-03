//
//  MainBundle.swift
//  Catalog
//
//  Created by Kevin Hardianto on 03/11/23.
//

import UIKit

public class MainBundle: NSObject {
  public static func getIdentifier() -> String {
      let bundle = Bundle(for: MainBundle.self)
      let identifier = bundle.bundleIdentifier
      return identifier ?? ""
  }
}
