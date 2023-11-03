# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

use_frameworks!
workspace 'Catalog'

target 'Catalog' do
  # Pods for Catalog
  pod 'RxSwift'
  pod 'RxCocoa'
  pod 'Alamofire'
  pod 'Kingfisher'
  pod 'SwiftLint'
  pod 'Core', :git => "https://github.com/kevinhardianto6/Core.git", :tag => '1.2.6'


end

target 'Profile' do
  project './Modules/Profile/Profile'
  pod 'Core', :git => "https://github.com/kevinhardianto6/Core.git", :tag => '1.2.6'
  pod 'RxSwift'
  pod 'RxCocoa'
end

target 'Game' do
  project './Modules/Game/Game'
  pod 'Core', :git => "https://github.com/kevinhardianto6/Core.git", :tag => '1.2.6'
  pod 'RxSwift'
  pod 'RxCocoa'
  pod 'Alamofire'
  pod 'Kingfisher'
end
