Pod::Spec.new do |s|
  s.name         = "YBPopupMenu"
  s.version      = "1.1.5"
  s.summary      = "快速集成popupMenu"
  s.description  = "Code created and updated by Lyb."
  s.homepage     = "https://github.com/lyb5834/YBPopupMenu.git"
  s.license      = "MIT"
  s.author       = { "lyb" => "lyb5834@126.com" }
  s.source       = { :git => "https://github.com/lyb5834/YBPopupMenu.git", :tag => s.version.to_s }
  s.source_files  = "YBPopupMenu/*.{h,m}"
  s.requires_arc = true
  s.platform     = :ios, '7.0'
end
