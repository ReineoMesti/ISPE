## 存放载具数据和功能的类
class_name vehicle extends RefCounted

## 载具的属性数值
var vehicleData: Dictionary

## 载具的功能对executor的参数
## 是一个id(int)到parameters(Array<String>)的映射
var vehicleFunctionParameters: Dictionary


func _init() -> void:
	pass # 可能后续会改动
	
## 本函数绑定至UI的信号系统
func executor(id: int) -> void:
	pass
