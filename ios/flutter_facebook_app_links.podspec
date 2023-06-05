#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#
Pod::Spec.new do |s|
  s.name             = 'flutter_facebook_app_links'
  s.version          = '3.0.0'
  s.summary          = 'A Flutter plugin to catch deferred deep links from Facebbok ads with FB App Links SDK.'
  s.description      = <<-DESC
Flutter plugin for Facebook App Links SDK
                       DESC
  s.homepage         = 'https://imwatching.app'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'Marco Nicotra' => 'm26.nicotra@gmail.com' }
  s.source           = { :path => '.' }
  s.source_files = 'Classes/**/*'
  s.public_header_files = 'Classes/**/*.h'
  s.dependency 'Flutter'
  s.dependency 'FBSDKCoreKit', '~> 16.0'
  s.swift_version       = '4.0'

  s.ios.deployment_target = '11.0'
end

