//
//  MoyaConvertable.swift
//  ABCNetworking
//
//  Created by PangJunJie on 2018/9/12.
//

import SwiftyJSON

public protocol MoyaConvertable: Codable {}

public extension MoyaConvertable {
    func toData() -> Data? {
        let encoder = JSONEncoder()
        
        guard let data = try? encoder.encode(self) else { return nil }
        
        return data
    }
    
    func toDictionary() -> [String: Any] {
        guard let data = toData() else { return [:] }
        
        guard let dict = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? Dictionary<String, Any> else { return [:] }
        
        return dict ?? [:]
    }
    
    func toJSONString() -> String {
        return toJSON().rawString() ?? ""
    }
    
    func toJSON() -> JSON {
        guard let data = toData() else { return JSON() }
        
        return JSON(data)
    }
}

