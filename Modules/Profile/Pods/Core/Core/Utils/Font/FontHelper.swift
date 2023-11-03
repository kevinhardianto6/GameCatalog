//
//  FontHelper.swift
//  Core
//
//  Created by Kevin Hardianto on 01/11/23.
//

import UIKit

public class FontHelper: NSObject {
    public static func registerFont(bundleIdentifier identifier: String, withName name: String, fileExtension: String) {
        guard let frameworkBundle = Bundle(identifier: identifier) else {
            print("Bundle Not Found")
            return
        }
        
        if let pathForResourceString = frameworkBundle.path(forResource: name, ofType: fileExtension),
           let fontData = NSData(contentsOfFile: pathForResourceString),
           let fontDataProvider = CGDataProvider(data: fontData) {
            if let font = CGFont(fontDataProvider) {
                var error: Unmanaged<CFError>?
                if CTFontManagerRegisterGraphicsFont(font, &error) {
                    print("Custom Font Registered Successfully")
                } else {
                    if let error = error?.takeRetainedValue() {
                        print("Error Registering Custom Font: \(error)")
                    }
                }
            }
        }
    }
    
    public static func loadCoreFont() {
        registerFont(bundleIdentifier: CoreBundle.getIdentifier(), withName: "Inter-Black", fileExtension: "ttf")
        registerFont(bundleIdentifier: CoreBundle.getIdentifier(), withName: "Inter-Bold", fileExtension: "ttf")
        registerFont(bundleIdentifier: CoreBundle.getIdentifier(), withName: "Inter-ExtraBold", fileExtension: "ttf")
        registerFont(bundleIdentifier: CoreBundle.getIdentifier(), withName: "Inter-ExtraLight", fileExtension: "ttf")
        registerFont(bundleIdentifier: CoreBundle.getIdentifier(), withName: "Inter-Light", fileExtension: "ttf")
        registerFont(bundleIdentifier: CoreBundle.getIdentifier(), withName: "Inter-Medium", fileExtension: "ttf")
        registerFont(bundleIdentifier: CoreBundle.getIdentifier(), withName: "Inter-Regular", fileExtension: "ttf")
        registerFont(bundleIdentifier: CoreBundle.getIdentifier(), withName: "Inter-SemiBold", fileExtension: "ttf")
        registerFont(bundleIdentifier: CoreBundle.getIdentifier(), withName: "Inter-Thin", fileExtension: "ttf")
    }
}
