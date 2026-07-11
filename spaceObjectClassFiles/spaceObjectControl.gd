class_name spaceObjectControl extends RefCounted

## 名字
var name: String
## 数据系统
var dataInstance: spaceObject
## 显示系统
var displayInstance: spaceObjectDisplay
## 常数
var mu: float

func _init(tag: String, orbitData: orbit3d, shapeData: shapedObject, parent: Node, mu_:float, 
	offset: Vector3 = Vector3.ZERO):
	name = tag
	dataInstance = spaceObject.new(orbitData, shapeData)
	displayInstance = spaceObjectDisplay.new(name, parent, offset)
	mu = mu_
func flush(time: float):
	displayInstance.moveTo(dataInstance.moveVector(mu, time) + dataInstance.orbit.majorFocus)
