//
//  SettingsOptionsController.swift
//  Demo
//
//  Created by ChenDong on 2018/12/6.
//

import UIKit
import RxSwift
import RxCocoa

// 负责一些全局变量的设置
class SettingsOptionsController: OptionsController {
    
    override init() {
        super.init()
        title = "Settings"
        
        weak var welf = self
        
        // 在 settings 有任何变化时，直接 reload 整个页面
        SettingsStore
            .changeObservable
            .subscribe(onNext: { (_) in
                guard let `self` = welf else { return }
                self.reloadSettings()
            })
            .disposed(by: bag)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func reloadSettings() {
        self.items = [
            tabBarIsTranslucentItem()
        ]
    }
    
    // 
    private func tabBarIsTranslucentItem() -> Item {
        let relay = SettingsStore.tabBarIsTranslucentRelay
        return Item(option: "tab bar is translucent: " + "\(relay.value.description)") {
            relay.accept(!relay.value)
        }
    }
}
