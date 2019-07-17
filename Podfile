# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

workspace 'HuaweiHilinkTestSignal'
project 'HuaweiHilinkTestSignalMac/HuaweiHilinkTestSignalMac.xcodeproj'
project 'HuaweiHilinkTestSignalIos/HuaweiHilinkTestSignalIos.xcodeproj'

source 'https://cdn.cocoapods.org/'

target 'HuaweiHilinkTestSignalMac' do
    project 'HuaweiHilinkTestSignalMac/HuaweiHilinkTestSignalMac.xcodeproj'
    platform :osx, '10.14'
    pod 'Alamofire', '~> 5.0.0-beta.5'
    pod "SwiftyXMLParser", :git => 'https://github.com/yahoojapan/SwiftyXMLParser.git'
end

target 'HuaweiHilinkTestSignalIos' do
    project 'HuaweiHilinkTestSignalIos/HuaweiHilinkTestSignalIos.xcodeproj'
	platform :ios, '12.0'
    pod 'Alamofire', '~> 5.0.0-beta.5'
    pod "SwiftyXMLParser", :git => 'https://github.com/yahoojapan/SwiftyXMLParser.git'
end