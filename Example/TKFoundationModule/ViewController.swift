//
//  ViewController.swift
//  TKFoundationModule
//
//  Created by zhuamaodeyu on 01/24/2019.
//  Copyright (c) 2019 zhuamaodeyu. All rights reserved.
//

import UIKit
import TKFoundationModule

class ViewController: UIViewController {

    fileprivate var tableView: UITableView!
    fileprivate var dataSource: [String: Any] = [:]

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView = UITableView.init(frame: view.bounds, style: .plain)
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
        dataSource.updateValue("1", forKey: "1")
    }
}
extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = SecondViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
extension ViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Array(dataSource.keys).count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellId = "XXXXXXXX"
        var cell = tableView.dequeueReusableCell(withIdentifier: cellId)
        if cell == nil {
            cell = UITableViewCell.init(style: .default, reuseIdentifier: cellId)
        }
        cell?.textLabel?.text = Array(dataSource.keys)[indexPath.row]
        return cell!
    }
}
