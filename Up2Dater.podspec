#
# Be sure to run `pod lib lint Up2Dater.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'Up2Dater'
  s.version          = '0.1.0'
  s.summary          = 'Keep the app up to date.'
  s.description      = <<-DESC
  Informs about the new available in the AppStore
  Fethces the JSON from the AppStore, compares correctly the latest version with the local bundle.
  DESC

  s.homepage         = 'https://github.com/12q/Up2Dater'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Slava Plisco' => 'observleer@gmail.com' }
  s.source           = { :git => 'https://github.com/12q/Up2Dater.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/observleer'
  s.swift_versions = '4.2'
  s.ios.deployment_target = '9.0'
  s.source_files = 'Up2Dater/Classes/**/*'
  
  # s.resource_bundles = {
  #   'Up2Dater' => ['Up2Dater/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
