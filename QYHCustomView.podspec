#
# Be sure to run `pod lib lint QYHCustomView.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'QYHCustomView'
  s.version          = '0.0.1'
  s.summary          = '各种自定义view，ProgressHUD & AlertView'
  s.description      = '各种自定义view，ProgressHUD & AlertView'
  s.homepage         = 'https://github.com/1039724903@qq.com/QYHCustomView'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { '1039724903@qq.com' => 'yonghuai.qiu@saj-electric.com' }
  s.platform     = :ios
  s.ios.deployment_target = '9.0'
  s.source           = { :git => 'https://github.com/1039724903@qq.com/QYHCustomView.git', :tag => s.version.to_s }
  s.requires_arc = true
  
  s.dependency "Masonry", "1.1.0"
  s.dependency "MBProgressHUD", "1.1.0"
  
  s.prefix_header_file = 'QYHCustomView/Classes/General/Macros/QYHPrefixHeader.pch'

  s.subspec 'Classes' do |classes|
    classes.subspec 'CustomView' do |customView|
        customView.source_files = 'QYHCustomView/Classes/CustomView/**/*'
    end
    classes.subspec 'General' do |general|
        general.source_files = 'QYHCustomView/Classes/General/**/*'
    end
  end
  
end
