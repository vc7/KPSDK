Pod::Spec.new do |spec|
  spec.name = "KPSDK"
  spec.version = "0.1"
  spec.summary = "This is a SDK for bridg 柯P's data API"
  spec.description = "" 
  spec.license = "MIT"
  spec.author = { "Vincent Chen" => "vince78718@gmail.com" }
  spec.ios.deployment_target = "7.0"
  spec.source = { :git => "http://www.github.com/vc7/KPSDK.git", :tag => "v#{spec.version}" }
	spec.source_files	= "KPSDK/*.{h,m}"
  spec.requires_arc = true
  spec.dependency "AFNetworking", "~> 2.0"
end
