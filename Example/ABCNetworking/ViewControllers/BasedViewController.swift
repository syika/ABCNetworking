//
//  BasedViewController.swift
//  ABCNetworking_Example
//
//  Created by PangJunJie on 2018/9/12.
//  Copyright © 2018年 CocoaPods. All rights reserved.
//

import UIKit
import RxSwift

class BasedViewController: UIViewController {
    let disbag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.white
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
