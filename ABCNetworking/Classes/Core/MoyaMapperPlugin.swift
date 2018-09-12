//
//  MoyaModelAble.swift
//  ABCNetworking
//
//  Created by PangJunJie on 2018/9/12.
//


import Moya
import Result

public struct MoyaMapperPlugin: PluginType {
    var parameter: ModelableParameterType.Type
    
    public init<T: ModelableParameterType>(_ type: T.Type) {
        parameter = type
    }
    
    public func process(_ result: Result<Response, MoyaError>, target: TargetType) -> Result<Response, MoyaError> {
        _ = result.map { (response) -> Response in
            response.setNetParameter(parameter)
            return response
        }
        return result
    }
}
