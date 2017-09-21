
Pod::Spec.new do |s|


  s.name         = "JPNavigationController"
  s.version      = "2.1.0"
  s.summary      = "This library provides an fullScreen pop and push gesture for UINavigationController with customize UINavigationBar for each single support."

s.description  =  'FullScreen pop gesture support'\
                    'FullScreen push gesture support'\
                    'Customize UINavigationBar for each single viewController support'\
                    'Add link view hovering in screen bottom support'\
                    'Customize pop and push gesture distance on the left side of the screen support'\
                    'Close pop gesture for single viewController support'\
                    'Close pop gesture for all viewController support'\
                    'Smooth AVPlayer playing when perform pop gesture'

  s.homepage     = "https://github.com/newyjp/JPNavigationController"
  s.license      = "MIT"
  s.author             = { "NewPan" => "13246884282@163.com" }

  s.ios.deployment_target = "8.0"
  # s.osx.deployment_target = "10.7"
  # s.watchos.deployment_target = "2.0"
  # s.tvos.deployment_target = "9.0"


  s.source       = { :git => 'https://github.com/newyjp/JPNavigationController.git', :tag => s.version }
  s.source_files  = 'JPNavigationController/**/*.{h,m}'
  s.resource     = 'JPNavigationController/JPNavigationController.bundle'
  s.frameworks = 'Foundation', 'UIKit'
  s.requires_arc = true

end
