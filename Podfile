# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'Thakkir' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!


pod 'PageMenu'
pod "AsyncSwift"
pod 'SlideMenuControllerSwift'
pod 'RealmSwift'
pod 'AFDateHelper'
pod 'Adhan'
pod 'Firebase/Core'
pod'Firebase/Messaging'
pod 'Fabric'
pod 'Crashlytics'

  # Pods for Thakkir

  target 'ThakkirUITests' do
    inherit! :search_paths
    # Pods for testing
  end

end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['SWIFT_VERSION'] = '3.0'
    end
  end
end
