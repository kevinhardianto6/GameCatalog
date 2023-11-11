#
#  Be sure to run `pod spec lint Core.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see https://guides.cocoapods.org/syntax/podspec.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|
  s.platform = :ios
  s.ios.deployment_target = '15.4'
  s.name = "Core"
  s.summary = "Core.framework for modularization chapter"
  s.requires_arc = true
  s.version = "1.2.4"
  s.license = { :type => "MIT", :file => "LICENSE" }
  s.author = { "Kevin Hardianto" => "hardiantokevin00@gmail.com" }
  s.homepage = "https://github.com/kevinhardianto6/Core"
  s.source = { 
    :git => "https://github.com/kevinhardianto6/Core.git", 
    :tag => "#{s.version}" 
  }
  s.framework = "UIKit"
  s.source_files = "Core", "Core/**/*.{h,m,swift}"
  s.resources = "Core/**/*.{png,jpeg,jpg,storyboard,xib,xcassets}"
  s.swift_version = "5.0"
end
