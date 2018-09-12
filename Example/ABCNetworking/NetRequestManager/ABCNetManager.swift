//
//  ABCNetManager.swift
//  ABCNetworking_Example
//
//  Created by PangJunJie on 2018/9/12.
//  Copyright © 2018年 CocoaPods. All rights reserved.
//

import Foundation
import Moya
import ABCNetworking

enum NetManager {
    enum NetworkCategory: String {
        case all     = "all"
        case android = "Android"
        case ios     = "iOS"
        case welfare = "福利"
    }
    
    case data(type: NetworkCategory, size:Int, index:Int)
    case multipleModel
}

extension NetManager: TargetType {
    var baseURL: URL {
        switch self {
        case .multipleModel:
            return URL(string: "http://jsonplaceholder.typicode.com/")!
        default:
            return URL(string: "http://gank.io/api/data/")!
        }
    }
    
    var path: String {
        switch self {
        case .multipleModel:
            return "users"
        case .data(let type, let size, let index):
            return "\(type.rawValue)/\(size)/\(index)"
        }
    }
    
    var method: Moya.Method {
        return .get
    }
    
    var sampleData: Data {
        return "".data(using: .utf8)!
    }
    
    var task: Task {
        return .requestPlain
    }
    
    var headers: [String : String]? {
        return nil
    }
}

struct NetParameter : ModelableParameterType {
    static var successValue: String { return "false" }
    static var statusCodeKey: String { return "error" }
    static var tipStrKey: String { return "errMsg" }
    static var modelKey: String { return "results" }
}

let netManager = MoyaProvider<NetManager>(plugins: [MoyaMapperPlugin(NetParameter.self)])

// MARK:- 自定义网络结果参数
struct CustomNetParameter: ModelableParameterType {
    static var successValue: String { return "false" }
    static var statusCodeKey: String { return "error" }
    static var tipStrKey: String { return "errMsg" }
    static var modelKey: String { return "results"}
}

















































