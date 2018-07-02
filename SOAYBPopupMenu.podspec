@version = "1.1.8"
@podName = "SOAYBPopupMenu"
@baseURL = "github.com"
@basePath = "josercc/YBPopupMenu"
@baseSourcePath = "#{@podName} Example/#{@podName}"
@baseFilePath = "**/*.{h,m}"
@source_files = "#{@baseSourcePath}/#{@baseFilePath}"
@frameworkName = "#{@podName}"
Pod::Spec.new do |s|
  s.name          = "#{@podName}"
  s.version       = @version
  s.summary       = "YBPopupMenu支持源码和 Framework"
  s.homepage      = "http://#{@baseURL}/#{@basePath}"
  s.license       = { :type => 'MIT', :file => 'LICENSE' }
  s.author        = { "josercc" => "josercc@163.com" }
  s.platform      = :ios, '8.0'
  s.source        = { :git => "#{s.homepage}.git", :tag => "#{s.version}" }
  s.framework     = "UIKit"
  s.subspec 'Source' do |source|
    source.source_files = @source_files
  end
  s.subspec 'Framework' do |framework|
    framework.vendored_frameworks = "Carthage/build/iOS/#{@frameworkName}.framework"

  end
  s.prepare_command =  <<-CMD
  touch Cartfile
  echo 'git "git@#{@baseURL}:#{@basePath}.git" == #{@version}' > Cartfile
  Carthage update --platform iOS
  CMD
  s.default_subspecs = 'Source'

#   s.resource_bundles = {
#     @podName => "#{@baseSourcePath}/**/*.{html}"
#   }

#   @subspec_config = [
#     "UIStyleComponent",
#     "UIStyleButton"
#   ]
#   @subspec_dependency = {
#     "UIStyleButton" => ["#{@podName}/UIStyleComponent"],
#   }
#   @subspec_config.each { |subspecName|
#     s.subspec subspecName do |n|
#       n.source_files = "#{@baseSourcePath}/#{subspecName}/#{@baseFilePath}"
#       @subspec_dependency.each { |name,list|
#         if name == subspecName
#           list.each { |e|
#             n.dependency e
#           }
#         end
#       }
#     end
#   }

end
