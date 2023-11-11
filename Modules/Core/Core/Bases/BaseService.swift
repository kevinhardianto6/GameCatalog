//
//  BaseService.swift
//  Core
//
//  Created by Kevin Hardianto on 11/11/23.
//

import UIKit

class BaseService: NSObject {
  lazy var BASE_KEY: String = {
      if let path = Bundle.main.path(forResource: "Info", ofType: "plist") {
          let dictionary = NSDictionary(contentsOfFile: path)
          return dictionary!["BASE_KEY"] as! String
      } else {
          return ""
      }
  }()
  
  lazy var BASE_URL: String = {
      if let path = Bundle.main.path(forResource: "Info", ofType: "plist") {
          let dictionary = NSDictionary(contentsOfFile: path)
          return dictionary!["BASE_URL"] as! String
      } else {
          return ""
      }
  }()
}
