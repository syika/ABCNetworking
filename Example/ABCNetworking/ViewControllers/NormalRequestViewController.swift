//
//  NormalRequestViewController.swift
//  ABCNetworking_Example
//
//  Created by PangJunJie on 2018/9/12.
//  Copyright © 2018年 CocoaPods. All rights reserved.
//

import UIKit
import Moya
import Result
import ABCNetworking

class NormalRequestViewController: BasedViewController {
    //MARK: - Properties
    typealias moyaResult = Result<Moya.Response, MoyaError>
    fileprivate let tableView = {() -> UITableView in
        let table = UITableView(frame: .zero, style: .plain)
        
        return table
    }()
    fileprivate let dataSource = [
        "models",
        "result",
        "modelsResult",
        "fetchString",
        "customNetParamer"
    ]
    
    //MARK: - View Circle Life
    override func viewDidLoad() {
        super.viewDidLoad()
        
        archiveCustomUI()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

// MARK: - Table View Delegate
extension NormalRequestViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellID = "cellID"
        
        var cell = tableView.dequeueReusableCell(withIdentifier: cellID)
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: cellID)
        }
        
        cell?.textLabel?.text = dataSource[indexPath.row]
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        
        var completion: Moya.Completion?
        
        if indexPath.row == 0 {
            completion = models(_:)
        } else if indexPath.row == 1 {
            completion = result(_:)
        } else if indexPath.row == 2 {
            completion = modelsResult(_:)
        } else if indexPath.row == 3 {
            completion = fetchString(_:)
        } else if indexPath.row == 4 {
            completion = customNetParamer(_:)
        }
        
        guard let xCompletion = completion else {
            return
        }
        
        netManager.request(.data(type: .all,
                                 size: 10,
                                 index: 1),
                           completion: xCompletion)
    }
}

// MARK: - Cell Selected
extension NormalRequestViewController {
    fileprivate func models(_ result: moyaResult) {
        guard let response = result.value else {
            return
        }
        
        let models = response.mapArray(MyModel.self)
        
        for model in models {
            print("id -- \(model._id)")
        }
    }
    
    fileprivate func result(_ result: moyaResult) {
        guard let response = result.value else {
            return
        }
        
        let (isSuccess, tipStr) = response.mapResult()
        print("isSuccess -- \(isSuccess)")
        print("tipStr -- \(tipStr)")
    }
    
    fileprivate func modelsResult(_ result: moyaResult) {
        guard let response = result.value else {
            return
        }
        
        let (result, models) = response.mapArrayResult(MyModel.self)
        print("isSuccess --\(result.0)")
        print("tipStr --\(result.1)")
        print("models count -- \(models.count)")
    }
    
    fileprivate func fetchString(_ result: moyaResult) {
        guard let response = result.value else { return }
        
        print(response.fetchJSONString())
        print(response.fetchJSONString(keys: [0]))
        
        print(response.fetchString(keys: [0, "_id"]))
    }
    
    fileprivate func customNetParamer(_ result: moyaResult) {
        guard let response = result.value else { return }
        
        let (isSuccess, tipStr) = response.mapResult { () -> (ModelableParameterType.Type) in
            return CustomNetParameter.self
        }
        
        print("isSuccess -- \(isSuccess)")
        print("tipStr -- \(tipStr)")
    }
    
    fileprivate func other(_ result: moyaResult) {
        /*
         guard let response = result.value else { return }
         
         response.mapObjResult(MyModel.self)
         response.mapArrayResult(MyModel.self)
         response.mapObject(MyModel.self)
         response.mapObject(MyModel.self, modelKey: "results")
         response.mapArray(MyModel.self, modelKey: "results")
         */
    }
}

// MARK: - Archive Custom
extension NormalRequestViewController {
    fileprivate func archiveCustomUI() {
        view.addSubview(tableView)
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.frame = view.bounds
    }
}





















































