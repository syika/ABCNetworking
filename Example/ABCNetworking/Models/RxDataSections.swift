//
//  RxDataSections.swift
//  ABCNetworking_Example
//
//  Created by PangJunJie on 2018/9/12.
//  Copyright © 2018年 CocoaPods. All rights reserved.
//

import RxDataSources

enum RxDataSections {
    case requests([RxDataSectionItem])
}

extension RxDataSections: SectionModelType {
    init(original: RxDataSections, items: [RxDataSectionItem]) {
        switch original {
            case .requests: self = .requests(items)
        }
    }
    
    var items: [RxDataSectionItem] {
        switch self {
        case .requests(let items): return items
        }
    }
}

enum RxDataSectionItem {
    case models
    case result
    case modelsResult
    case fetchString
    case customNetParamer
}




































