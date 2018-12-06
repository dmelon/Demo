//
//  SettingsStore.swift
//  Demo
//
//  Created by ChenDong on 2018/12/6.
//

import Foundation
import RxSwift
import RxCocoa

class SettingsStore {
        
    // tab bar 是否是 translucent
    static let tabBarIsTranslucentRelay = BehaviorRelay(value: true)

    static var changeObservable: Observable<Void> {
        let obs = [
            tabBarIsTranslucentRelay.map({ _ in () })
        ]
        return Observable.merge(obs)
    }
}
