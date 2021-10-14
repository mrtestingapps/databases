Pod::Spec.new do |s|

# 1
s.platform = :ios
s.ios.deployment_target = '14.4'
s.name = "Databases"
s.summary = "Databases lets a user interact with databases."
s.requires_arc = true

# 2
s.version = "0.1.0"

# 3
s.license = { :type => "MIT", :file => "LICENSE" }

# 4 - Replace with your name and e-mail address
s.author = { "mrtestingapps" => "mrtestingapps@gmail.com" }

# 5 - Replace this URL with your own GitHub page's URL (from the address bar)
s.homepage = "https://github.com/TheCodedSelf/RWPickFlavor"

# 6 - Replace this URL with your own Git URL from "Quick Setup"
s.source = { :git => "https://github.com/mrtestingapps/databases.git", 
             :tag => "#{s.version}" }

# 7
s.framework = "UIKit"
# 8
s.source_files = "Databases/**/*.{swift}"

# 9
s.resources = "Databases/**/*.{png,jpeg,jpg,storyboard,xib,xcassets}"

# 10
s.swift_version = "5.0"

end
