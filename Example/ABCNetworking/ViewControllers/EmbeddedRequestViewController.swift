//
//  EmbeddedRequestViewController.swift
//  ABCNetworking_Example
//
//  Created by PangJunJie on 2018/9/12.
//  Copyright © 2018年 CocoaPods. All rights reserved.
//

import UIKit

class EmbeddedRequestViewController: BasedViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        netManager.rx.request(.multipleModel).mapArray(UserModel.self, modelKey: "").subscribe(onSuccess: { (models) in
            for model in models {
                print(model.email)
                print(model.address.city)
                print(model.address.geo.lat)
                print(model.company.catchPhrase)
            }
        }).disposed(by: disbag)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
