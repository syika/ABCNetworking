//
//  RxSwiftRequestViewController.swift
//  ABCNetworking_Example
//
//  Created by PangJunJie on 2018/9/12.
//  Copyright © 2018年 CocoaPods. All rights reserved.
//

import Moya
import UIKit
import RxSwift
import RxCocoa
import RxDataSources
import ABCNetworking
import HandyJSON

class RxSwiftRequestViewController: BasedViewController {
    //MARK: Properties
    let request = netManager.rx.request(.data(type: .all, size: 10, index: 1))
    let tableView = { () -> UITableView in
        let table = UITableView(frame: .zero,
                                style: .plain)
        
        return table
    }()
    let sections: [RxDataSections] = [
        RxDataSections.requests([
            .models,
            .result,
            .modelsResult,
            .fetchString,
            .customNetParamer
            ])
    ]
    let dataSource: RxTableViewSectionedReloadDataSource<RxDataSections> = {
        return RxTableViewSectionedReloadDataSource.init(configureCell: { (dataSource, tableView, indexPath, sectionItem) -> UITableViewCell in
            let cellID = "rxMoyaCellID"
            var cell = tableView.dequeueReusableCell(withIdentifier: cellID)
            if cell == nil { cell = UITableViewCell(style: .default, reuseIdentifier: cellID) }
            
            switch sectionItem {
            case .models:
                cell?.textLabel?.text = "models"
            case .result:
                cell?.textLabel?.text = "result"
            case .modelsResult:
                cell?.textLabel?.text = "modelsResult"
            case .fetchString:
                cell?.textLabel?.text = "fetchString"
            case .customNetParamer:
                cell?.textLabel?.text = "customNetParamer"
            }
            
            return cell!
        })
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        archiveCustomUI()
    }
}

// MARK: - Touch Event
extension RxSwiftRequestViewController {
    func mapModels() -> Void {
        #if false
        request.fetchJSONString().subscribe(onSuccess: { (str) in
            if let models = [HandyModel].deserialize(from: str) {
                models.forEach({ (model) in
                    print(model ?? "")
                })
            }
        }).disposed(by: disbag)
        #endif
        request.mapHandyModelsWithResult(HandyModel.self) { () -> (ModelableParameterType.Type) in
            return CustomNetParameter.self
            }.subscribe(onSuccess: { (result, array) in
                print(result)
                print(array)
            }).disposed(by: disbag)
    }
    
    func models() -> Void {
        request.mapArray(MyModel.self).subscribe(onSuccess: { (models) in
            for model in models {
                print("id -- \(model._id)")
            }
        }).disposed(by: disbag)
    }
    
    func result() -> Void {
        request.mapResult().subscribe(onSuccess: { (isSuccess, tipStr) in
            print("isSuccess -- \(isSuccess)")
            print("tipStr -- \(tipStr)")
        }).disposed(by: disbag)
    }
    
    fileprivate func modelsResult() {
        request.catchError { (error) -> PrimitiveSequence<SingleTrait, Response> in
            // 捕获请求失败（如：无网状态），自定义response
            let err = error as NSError
            let resBodyDict = ["error":"true", "errMsg":err.localizedDescription]
            let response = Response(resBodyDict, statusCode: 203, parameterType: NetParameter.self)
            return Single.just(response)
            }.mapArrayResult(MyModel.self).subscribe(onSuccess: { (result, models) in
                print("isSuccess --\(result.0)")
                print("tipStr --\(result.1)")
                print("models count -- \(models.count)")
            }).disposed(by: disbag)
    }
    
    fileprivate func fetchString() {
        // 获取指定路径的值
        #if true
        request.fetchString(keys: [0, "_id"]).subscribe(onSuccess: { str in
            // 取第1条数据中的'_id'字段对应的值
            print("str -- \(str)")
        }).disposed(by: disbag)
        #endif
    }
    
    fileprivate func customNetParamer() {
        request.mapResult { () -> (ModelableParameterType.Type) in
            return CustomNetParameter.self
            }.subscribe(onSuccess: { (isSuccess, tipStr) in
                print("isSuccess -- \(isSuccess)")
                print("tipStr -- \(tipStr)")
            }).disposed(by: disbag)
    }
    
    fileprivate func other() {
        /*
         request.mapObjResult(MyModel.self)
         request.mapArrayResult(MyModel.self)
         request.mapObject(MyModel.self)
         request.mapObject(MyModel.self, modelKey: "results")
         request.mapArray(MyModel.self, modelKey: "results")
         */
    }
}

// MARK: - Archive Custom
extension RxSwiftRequestViewController: UITableViewDelegate {
    func archiveCustomUI() -> Void {
        tableView.rx.setDelegate(self).disposed(by: disbag)
        tableView.frame = view.bounds
        view.addSubview(tableView)
        Observable.just(sections).bind(to: tableView.rx.items(dataSource: dataSource)).disposed(by: disbag)
        
        tableView.rx.modelSelected(RxDataSectionItem.self).subscribe(onNext: { [weak self](item) in
            switch item {
            case .models:
                self?.mapModels()
            case .result:
                self?.result()
            case .modelsResult:
                self?.modelsResult()
            case .fetchString:
                self?.fetchString()
            case .customNetParamer:
                self?.customNetParamer()
            }
        }).disposed(by: disbag)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
    }
}
