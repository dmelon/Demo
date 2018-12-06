//
//  ViewController.swift
//  Demo
//
//  Created by ChenDong on 2018/12/6.
//

import UIKit
import RxSwift

class ViewController: UIViewController {
    
    let bag = DisposeBag()
    
    class var navigationTitle: String {
        var txt = NSStringFromClass(self)
        txt = txt.components(separatedBy: ".").last!
        txt = txt.components(separatedBy: "Controller").first!
        return txt.splitedCamelString
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = type(of: self).navigationTitle
        view.backgroundColor = .white
    }
    
    required init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


