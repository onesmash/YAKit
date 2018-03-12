Pod::Spec.new do |s|
  s.name         = "YAKit"
  s.version      = "0.1.8"
  s.summary      = "YAKit"

  s.description  = <<-DESC
  YAKit is for fun!
                   DESC

  s.homepage     = "https://github.com/onesmash/YAKit"

  s.license      = { :type => "MIT", :file => "LICENSE" }

  s.author             = "good122000@qq.com"

  s.platform     = :ios, "8.0"
  s.source       = { :git => "https://github.com/onesmash/YAKit.git", :tag => "#{s.version}" }

  s.source_files  = "YAKit", "YAKit/**/*.{h,m,mm,cpp}"

  s.public_header_files = ["YAKit/YAKit.h", "YAKit/Foundation/Architecture/NSObject+YAComponent.h", "YAKit/Foundation/Architecture/YAComponentProtocol.h", "YAKit/Foundation/Architecture/YAComponent.h", "YAKit/UIKit/**/*.h", "YAKit/Foundation/Serialization/YAModel.h", "YAKit/Foundation/Observe/NSObject+YAObserve.h", "YAKit/Foundation/MMap/YAMMapFile.h", "YAKit/Foundation/Category/NSString+YA.h", "YAKit/Foundation/Swizzle/NSObject+YASwizzle.h"]

  s.libraries = 'c++'

  s.dependency 'KVOController'

end
