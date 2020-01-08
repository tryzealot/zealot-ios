#
# Be sure to run `pod lib lint Zealot.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'Zealot'
  s.version          = '0.1.0'
  s.summary          = 'App new beta version check for zealot. Learn more at https://zealot.ews.im'
  s.homepage         = 'https://zealot.ews.im'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'icyleaf' => 'icyleaf.cn@gmail.com' }
  s.source           = { :git => 'https://github.com/getzealot/zealot-ios', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '9.0'

  s.source_files = 'Zealot/Classes/**/*.swift'
  
  # s.resource_bundles = {
  #   'Zealot' => ['Zealot/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
