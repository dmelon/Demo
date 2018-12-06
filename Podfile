use_frameworks!

# ignore all warnings from all pods
inhibit_all_warnings!

def rx_pods
    pod 'RxCocoa', '~> 4.4.0'
    pod 'RxSwift', '~> 4.4.0'
end

def ui_pods
    pod 'SnapKit', '~> 4.2.0'
end

def network_pods
    pod 'Alamofire', '~> 4.8.0'
end

target 'Demo' do
    platform :ios, '9.0'

    ui_pods
    rx_pods
end
