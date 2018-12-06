//
//  SettingsStore.swift
//  Demo
//
//  Created by ChenDong on 2018/12/6.
//

import Foundation
import RxSwift
import RxCocoa

// 全局变量的设置，
class SettingsStore {
        
    // tab bar 是否是 translucent
    static let tabBarIsTranslucentRelay = BehaviorRelay(value: true)

    // 当有任何 Settings 变化时，该 Observable 都会发送 next event
    static var changeObservable: Observable<Void> {
        let obs = [
            tabBarIsTranslucentRelay.map({ _ in () })
        ]
        return Observable.merge(obs)
    }
}
