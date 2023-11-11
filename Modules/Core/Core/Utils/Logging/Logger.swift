//
//  Logger.swift
//  Catalog
//
//  Created by Kevin Hardianto on 01/10/23.
//

import UIKit

public class Logger: NSObject {
  public class func printLog(_ items: Any?) {
    print(items ?? "=== printLog empty")
  }
}
