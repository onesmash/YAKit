Pod::Spec.new do |s|
  s.name         = "YAKit"
  s.version      = "0.0.1"
  s.summary      = "YAKit"

  s.description  = <<-DESC
  YAKit is for fun!
                   DESC

  s.homepage     = "https://github.com/onesmash/YAKit"

  s.license      = { :type => "MIT", :file => "LICENSE" }

  s.author             = "good122000@qq.com"

  s.platform     = :ios, "9.0"

  s.source       = { :git => "https://github.com/onesmash/YAKit.git", :tag => "#{s.version}" }

  s.source_files  = "YAKit", "YAKit/**/*.{h,m}"

  s.public_header_files = ["YAKit/YAKit.h", "YAKit/Foundation/Architecture/NSObject+YAComponent.h", "YAKit/Foundation/Architecture/YAComponentProtocol.h", "YAKit/Foundation/Architecture/YAComponent.h", "YAKit/UIKit/Presenter/YAViewPresenterProtocol.h", "YAKit/UIKit/Presenter/YAVCPresenterProtocol.h"]

end
