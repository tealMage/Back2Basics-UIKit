# Uncomment the next line to define a global platform for your project
 platform :ios, '12.0'
 use_frameworks!
 inhibit_all_warnings!

 def shared_pods
  pod 'RxSwift', '~> 6.1'
  pod 'RxCocoa', '~> 6.1'
  pod 'Kingfisher', '5.13.0'

end

target 'Back2Basics' do
  shared_pods
  pod 'SwiftLint', '~> 0.42'


end

target 'Back2BasicsTests' do
  inherit! :search_paths
  shared_pods
  pod 'OCMock', '~> 3.8'
  pod 'RxTest', '~> 6.1'

end

target 'Back2BasicsUITests' do
end
