class_name spaceObjectControl extends RefCounted

## 名字
var name: String
## 数据系统
var dataInstance: spaceObject
## 显示系统
var displayInstance: spaceObjectDisplay
## 常数
var mu: float

func _init(uiLayer: CanvasLayer, camera: Camera3D, tag: String, orbitData: orbit3d, shapeData: shapedObject, 
	parent: Node3D, mu_:float, offset: Vector2 = Vector2.ZERO):
	name = tag
	dataInstance = spaceObject.new(orbitData, shapeData)
	var orbitDisplayInstance: orbitDisplay
	orbitDisplayInstance = orbitDisplay.new(parent, dataInstance.orbit.centerPosition, 0, 2 * PI, 60, true)
	displayInstance = spaceObjectDisplay.new(name, orbitDisplayInstance, uiLayer, camera, parent, offset)
	mu = mu_
func flush(time: float):
	displayInstance.reassignInfoWindowText("试验性文本:%3d" % time)
	displayInstance.moveTo(dataInstance.moveVector(mu, time) + dataInstance.orbit.majorFocus)
