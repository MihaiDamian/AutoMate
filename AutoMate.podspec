Pod::Spec.new do |s|
  s.name         = "AutoMate"
  s.version      = "0.1"
  s.summary      = "Swift framework containing set of helpful XCTest extensions for writing UI automation tests."
  s.homepage     = "https://github.com/PGSSoft/AutoMate"

  s.license      = "MIT"

  s.authors    = { "Joanna Bednarz" => "jbednarz@pgs-soft.com", "Pawel Szot" => "pszot@pgs-soft.com" }

  s.ios.deployment_target = '9.0'
  s.osx.deployment_target = '10.11'
  s.watchos.deployment_target = '2.0'
  s.tvos.deployment_target = '9.0'

  s.source       = { :git => "https://github.com/PGSSoft/AutoMate.git", :tag => "#{s.version}" }

  s.source_files  = "Classes", "AutoMate/**/*.{swift}"

  s.framework  = "XCTest"
end
