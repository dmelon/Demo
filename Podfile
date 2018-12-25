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

def test_pods
    pod 'Quick', '~> 1.3.2'
    pod 'Nimble', '~> 7.3.0'
end

target 'Demo' do
    platform :ios, '9.0'

    pod 'Result', '~> 4.0.0'
    ui_pods
    rx_pods
end

target 'DemoTests' do
    platform :ios, '9.0'

    test_pods
end

