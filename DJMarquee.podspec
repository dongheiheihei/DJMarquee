
Pod::Spec.new do |s|

  s.name         = "DJMarquee"
  s.version      = "1.0.0"
  s.summary      = "一个可以横向滚动和竖向滚动的跑马灯"
  s.description  = <<-DESC
  这是一款可以随意设置布局的跑马灯，里面是个自定义view，可以任意布局和添加控件，既可以横向滑动，还可以竖向滑动。
                   DESC

  s.homepage     = "https://github.com/dongheiheihei/DJMarquee"
  # s.screenshots  = "www.example.com/screenshots_1.gif", "www.example.com/screenshots_2.gif"

  s.license      = { :type => 'MIT', :file => 'LICENSE' }

  s.author             = { "dongheiheihei" => "woshidongheihei@163.com" }
   s.platform     = :ios, "10.0"

  s.source       = { :git => "https://github.com/dongheiheihei/DJMarquee.git", :tag => "#{s.version}" }
  s.source_files = 'DJMarquee/DJMarquee.framework/Headers/*.{h}'

  # s.public_header_files = "Classes/**/*.h"
  # s.public_header_files = "DJSpecialHUD/DJMarquee.framework/Headers/DJHUD.h"
  #s.resources = "DJSpecialHUD/DJProgressHUD.bundle"

  s.vendored_frameworks = 'DJMarquee/DJMarquee.framework'
  s.ios.frameworks = 'Foundation', 'UIKit'

  # s.library   = "iconv"
  # s.libraries = "iconv", "xml2"
  #s.dependency 'MBProgressHUD'

 s.requires_arc = true

end
