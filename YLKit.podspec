Pod::Spec.new do |s|

  s.name         = "YLKit"
  s.version      = "5.0.2"
  s.summary      = "empty"
  s.homepage     = "https://github.com/zhouyouyali/YLKit"
  s.license      = 'MIT'
  s.author             = { "zhouyouyali" => "814307045@qq.com" }
  s.source       = { :git => "https://github.com/zhouyouyali/YLKit.git", :tag => s.version.to_s}
  s.source_files = "YLKit/*.{h}","YLKit/**/*.{h,m}"
  s.platform     = :ios, '8.0'
  s.requires_arc = true
  s.frameworks   = "UIKit","Foundation"

end
