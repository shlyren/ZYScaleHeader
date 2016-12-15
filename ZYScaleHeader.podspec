
Pod::Spec.new do |s|
  s.name         = "ZYScaleHeader"
  s.version      = "1.0.1"
  s.summary      = "一个下拉头部缩放视图的分类"
  s.homepage     = "https://github.com/shlyren/ZYScaleHeader"
  s.license      = { :type => 'MIT', :file => 'LICENSE' }
  s.author       = { "shlyren" => "mail@yuxiang.ren" }
  s.platform     = :ios, "8.0"
  s.source       = { :git => "https://github.com/shlyren/ZYScaleHeader.git", :tag => "#{s.version}" }

  s.requires_arc =  true
  #s.public_header_files = 'ZYScaleHeader/ZYScaleHeader.h'
  s.source_files = "ZYScaleHeader/*.{h,m}"
  
end
