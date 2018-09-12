//
//  ViewController.swift
//  ABCNetworking
//
//  Created by PangJunJie on 09/11/2018.
//  Copyright (c) 2018 PangJunJie. All rights reserved.
//

import UIKit

class ViewController: BasedViewController {
    /**数组*/
    let dataArray = ["普通Moya网络请求", "RxMoya网络请求", "模型嵌套解析"]
    let tableView = {() -> UITableView in
        let table = UITableView(frame: .zero, style: .plain)
        
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

// MARK: - TableView Delegate
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellID = "cellID"
        
        var cell = tableView.dequeueReusableCell(withIdentifier: cellID)
        if cell == nil {
            cell = UITableViewCell(style: .default,
                                   reuseIdentifier: cellID)
        }
        cell?.textLabel?.text = dataArray[indexPath.row]
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        
        var viewController: UIViewController?
        if indexPath.row == 0 {
            viewController = NormalRequestViewController()
        } else if indexPath.row == 1 {
            viewController = RxSwiftRequestViewController()
        } else {
            viewController = EmbeddedRequestViewController()
        }
        
        if viewController == nil { return }
        viewController?.title = dataArray[indexPath.row]
        
        self.navigationController?.pushViewController(viewController!, animated: true)
    }
}

// MARK: - Archive Custom UI
extension ViewController {
    func configureUI() -> Void {
        title = "ABCNetWorking"
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.frame = view.bounds
        
        view.addSubview(tableView)
    }
}

