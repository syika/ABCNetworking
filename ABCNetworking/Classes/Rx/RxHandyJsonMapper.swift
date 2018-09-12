//
//  RxHandyJsonMapper.swift
//  Pods
//
//  Created by PangJunJie on 2018/9/12.
//

import RxSwift
import Moya
import SwiftyJSON
import HandyJSON

// MARK: - 基于HandyJson实现
// MARK: - 将response转换实现为Observable<Any>
extension ObservableType where E == Response {
    /// mapHandyModels 通过HandyJson获取Model数组
    ///
    /// - Parameters:
    ///   - type: 模型类型
    ///   - modelKey: 模型数据路径
    /// - Returns: Observable<Model>
    public func mapHandyModel<T: HandyJSON>(_ type: T.Type, modelKey: String? = nil) -> Observable<T?> {
        return flatMap { response -> Observable<T?> in
            return Observable.just(response.mapModel(type))
        }
    }
    
    /// mapHandyModelWithResult
    ///
    /// - Parameters:
    ///   - type: 模型类型
    ///   - params: 自定义解析的设置回调
    /// - Returns: Observable<(MoyaMapperResult, T?)>
    public func mapHandyModelWithResult<T: HandyJSON>(_ type: T.Type, params: ModelableParamsBlock? = nil) -> Observable<(MoyaMapperResult, T?)> {
        return flatMap { response -> Observable<(MoyaMapperResult, T?)> in
            return Observable.just(response.mapModelResult(type))
        }
    }
    
    /// mapHandyModels 通过HandyJson获取Model数组
    ///
    /// - Parameters:
    ///   - type: 模型类型
    ///   - path: JSON数据路径 (默认为模型数据路径)
    ///   - keys: 目标数据子路径
    /// - Returns: Observable<[T]>
    public func mapHandyModels<T: HandyJSON>(_ type: T.Type,
                                             designatedPath path: String? = nil,
                                             keys: [JSONSubscriptType] = []) -> Observable<[T]> {
        return flatMap { response ->  Observable<[T]> in
            return Observable.just(response.mapModelArray(type))
        }
    }
    
    /// mapHandyModelsWithResult
    ///
    /// - Parameters:
    ///   - type: 模型类型
    ///   - params: 自定义解析的设置回调
    /// - Returns: Observable<(MoyaMapperResult, T?)>
    public func mapHandyModelsWithResult<T: HandyJSON>(_ type: T.Type, params: ModelableParamsBlock? = nil) -> Observable<(MoyaMapperResult, [T])> {
        return flatMap { response -> Observable<(MoyaMapperResult, [T])> in
            return Observable.just(response.mapModelArrayResult(type))
        }
    }
}

// MARK: - Json -> Single<Model>
extension PrimitiveSequence where TraitType == SingleTrait, E == Response {
    /// mapHandyModels 通过HandyJson获取Model数组
    ///
    /// - Parameters:
    ///   - type: 模型类型
    ///   - modelKey: 模型数据路径
    /// - Returns: Single<Model>
    public func mapHandyModel<T: HandyJSON>(_ type: T.Type, modelKey: String? = nil) -> Single<T?> {
        return flatMap { response -> Single<T?> in
            return Single.just(response.mapModel(type))
        }
    }
    
    /// mapHandyModels 通过HandyJson获取Model数组
    ///
    /// - Parameters:
    ///   - type: 模型类型
    ///   - path: JSON数据路径 (默认为模型数据路径)
    ///   - keys: 目标数据子路径
    /// - Returns: Single<[T]>
    public func mapHandyModels<T: HandyJSON>(_ type: T.Type,
                                             designatedPath path: String? = nil,
                                             keys: [JSONSubscriptType] = []) -> Single<[T]> {
        return flatMap { response ->  Single<[T]> in
            return Single.just(response.mapModelArray(type))
        }
    }
    
    /// mapHandyModelWithResult
    ///
    /// - Parameters:
    ///   - type: 模型类型
    ///   - params: 自定义解析的设置回调
    /// - Returns: Single<(MoyaMapperResult, T?)>
    public func mapHandyModelWithResult<T: HandyJSON>(_ type: T.Type, params: ModelableParamsBlock? = nil) -> Single<(MoyaMapperResult, T?)> {
        return flatMap { response -> Single<(MoyaMapperResult, T?)> in
            return Single.just(response.mapModelResult(type))
        }
    }
    /// mapHandyModelsWithResult
    ///
    /// - Parameters:
    ///   - type: 模型类型
    ///   - params: 自定义解析的设置回调
    /// - Returns: Single<(MoyaMapperResult, T?)>
    public func mapHandyModelsWithResult<T: HandyJSON>(_ type: T.Type, params: ModelableParamsBlock? = nil) -> Single<(MoyaMapperResult, [T])> {
        return flatMap { response -> Single<(MoyaMapperResult, [T])> in
            return Single.just(response.mapModelArrayResult(type))
        }
    }
}






























