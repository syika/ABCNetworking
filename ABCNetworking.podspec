Pod::Spec.new do |s|
  s.name             = 'ABCNetworking'
  s.version          = '0.1.0'
  s.summary          = 'Comman NetWorking Request Tools'

  s.description      = <<-DESC
  Comman NetWOrking Request Tools Based On The Layer Use Moya
                       DESC

  s.homepage         = 'git@github.com:syika/ABCNetworking.git'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'PangJunJie' => 'xwhnnd@163.com' }
  s.source           = { :git => 'git@github.com:syika/ABCNetworking.git', :tag => s.version.to_s }

  s.ios.deployment_target = '9.0'

  s.default_subspec = "Core"
  
  s.subspec "Core" do |ss|
      ss.source_files  = "ABCNetworking/Classes/Core"
      
      ss.dependency "Moya", ">= 11.0.0"
      ss.dependency "SwiftyJSON"
  end
  
  s.subspec "Rx" do |rx|
      rx.source_files = "ABCNetworking/Classes/Rx"
      rx.dependency "Moya/RxSwift", ">= 11.0.0"
      rx.dependency 'HandyJSON', '~> 4.1.1'
      rx.dependency "RxSwift"
      rx.dependency "ABCNetworking/Core"
  end
  
end
