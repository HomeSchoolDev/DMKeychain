#
#  Be sure to run `pod spec lint MAConstraint.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|

  # ―――  Spec Metadata  ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  These will help people to find your library, and whilst it
  #  can feel like a chore to fill in it's definitely to your advantage. The
  #  summary should be tweet-length, and the description more in depth.
  #

  s.name         = "DMKeychain"
  s.version      = "1.0.0"
  s.summary      = "This Cocoapod will allow you to easily store things in the iOS keychain"
  s.homepage     = "https://github.com/HomeSchoolDev/DMKeychain"

  s.license      = { "type" => "MIT", "file" => "LICENSE.txt" }

  s.author             = { "Derek" => "derekm9292@gmail.com" }
  s.social_media_url   = "http://twitter.com/Derek_maurer"


  s.source       = { :git => "https://github.com/HomeSchoolDev/DMKeychain.git", :tag => "1.0.0" }
  s.platform = :ios, '7.0'
  s.source_files  = "*.{h,m}"
  s.requires_arc = true

end
