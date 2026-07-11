class_name spaceObject extends RefCounted

static var lib = orbitCalcLib

## 轨道参数
var orbit: orbit3d

## 物体模型类
var model: shapedObject

func _init(orbitInstance: orbit3d, modelInstance: shapedObject):
	orbit = orbitInstance
	model = modelInstance

## 生成指定时刻的位置向量
func moveVector(mu:float, time:float) -> Vector3:
	return lib.get_vector(orbit, mu, time)
