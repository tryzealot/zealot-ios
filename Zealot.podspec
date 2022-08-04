#
# Be sure to run `pod lib lint Zealot.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'Zealot'
  s.version          = '0.2.1'
  s.summary          = 'App new beta version check for zealot. Learn more at https://zealot.ews.im'
  s.homepage         = 'https://zealot.ews.im'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'icyleaf' => 'icyleaf.cn@gmail.com' }
  s.source           = { :git => 'https://github.com/tryzealot/zealot-ios.git', :tag => s.version.to_s }
  s.swift_version    = '5.1'

  s.ios.deployment_target = '8.0'

  s.source_files = 'Zealot/Classes/**/*.swift'
end
