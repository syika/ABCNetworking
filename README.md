# ABCNetWorking使用教程

## ABCNetWorking目前使用的是Moya+SwiftyJson的方式来实现的

1. 相关知识:
 	
 	Moya: [Moya官方文档](https://github.com/Moya/Moya)
   
   Alamofire: [Alamofire官方文档](https://github.com/Alamofire/Alamofire)
 
   SwiftyJson: [SwiftJson官方文档](https://github.com/SwiftyJSON/SwiftyJSON)
   
   
2. 使用方法

	*一 、* 注入插件
	
	1. 定义一个遵守ModelableParameterType协议的结构体

	```
	// 各参数返回的内容请参考下面JSON数据对照图
struct NetParameter : ModelableParameterType {
    static var successValue: String { return "false" }
    static var statusCodeKey: String { return "error" }
    static var tipStrKey: String { return "" }
    static var modelKey: String { return "results" }
}

	还可以做简单的路径处理, 使用'>'隔开 如：
	error: {
    'errorStatus':false
    'errMsg':'error Argument type'
    }
    static var tipStrKey: String { return "error>errorMsg"}
	```
	
	2. 以插件模式传递给MoyaProvider

	```
	let provider = MoyaProvider<ModelType>(plugins: [MoyaMapperPlugin(NetParameter.self)])
	```
	
	*二 、* 定义模型
	
	1. 创建遵守Modelable协议的结构休

	```
	struct MyModel: Modelable {
    
    var _id : String
    var address : AddressModel
    ......
    
    init?(_ json: JSON) {
        self._id = json["_id"].stringValue
        self.address = json["address"].modelValue(AddressModel.self)
        ......
    }
	}
struct AddressModel: Modelable {
    
    var street : String
    ......
    
    init(_ json: JSON) {
        self.street = json["street"].stringValue
        ......
    }
}

	```
	
	2. 模型嵌套解析

	使用泛型的方式为 JSON 类拓展两个解析方法，使解析模型嵌套易如反掌
	
	```
	// 解析单个模型
modelValue<T: Modelable>(_ type: T.Type) -> T
// 解析数组模型
modelsValue<T: Modelable>(_ type: T.Type) -> [T]
```


	
	