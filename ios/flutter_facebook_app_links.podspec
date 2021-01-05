#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#
Pod::Spec.new do |s|
  s.name             = 'flutter_facebook_app_links'
  s.version          = '0.0.1'
  s.summary          = 'A new flutter plugin project.'
  s.description      = <<~DESC
    Flutter plugin for Facebook App Links SDK
  DESC
  s.homepage         = 'http://example.com'
  s.license          = { file: '../LICENSE' }
  s.author           = { 'Your Company' => 'email@example.com' }
  s.source           = { path: '.' }
  s.source_files = 'Classes/**/*'
  s.public_header_files = 'Classes/**/*.h'
  s.dependency 'Flutter'
  s.dependency 'FBSDKCoreKit', '~> 8.2'
  s.swift_version = '4.0'

  s.ios.deployment_target = '9.0'
end
