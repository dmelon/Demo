//
//  OptionsController.swift
//  Demo
//
//  Created by ChenDong on 2018/12/6.
//

import UIKit
import RxSwift

class OptionsController: UITableViewController {
    
    let bag = DisposeBag()
    
    struct Item {
        let option: String
        let selection: () -> Void
    }
    
    var items: [Item] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    init() {
        super.init(nibName: nil, bundle: nil)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: NSStringFromClass(UITableViewCell.self))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension OptionsController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NSStringFromClass(UITableViewCell.self), for: indexPath)
        cell.textLabel?.text = items[indexPath.row].option
        return cell
    }
}

extension OptionsController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        items[indexPath.row].selection()
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension OptionsController {
    // 注册某个 ViewController 子类，在 select 时 push 一个实例
    func push(_ type: ViewController.Type) -> Item {
        weak var welf = self
        let item = Item(option: type.navigationTitle, selection: {
            guard let `self` = welf, let nv = self.navigationController else { fatalError() }
            let vc = type.init()
            nv.pushViewController(vc, animated: true)
        })
        return item
    }
}
