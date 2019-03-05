#
# Be sure to run `pod lib lint Coordinators.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'Coordinators'
  s.version          = '1.0.3'
  s.summary          = 'A framework for light flexible Swift MVVM coordinators'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
A framework for simple and flexible Swift Coordinators. Ideal to be used with MVVM+Coordinator architectures.
                       DESC

  s.homepage         = 'https://github.com/Bitdreams/Coordinators'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'raphaelcruzeiro' => 'raphael@bitdreams.co' }
  s.source           = { :git => 'https://github.com/Bitdreams/Coordinators.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/rcdeveloper'

  s.ios.deployment_target = '10.0'

  s.source_files = 'Coordinators/Classes/**/*'
  
  # s.resource_bundles = {
  #   'Coordinators' => ['Coordinators/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  s.frameworks = 'UIKit'
  s.dependency 'RxSwift', '4.4.1'
end
