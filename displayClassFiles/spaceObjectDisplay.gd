class_name spaceObjectDisplay extends RefCounted

## 用于标称名字的标签实例
var labelInstance: Label3D
## 用于设置文本悬停高度的向量，一般需要是Vector3.UP正向的
var positionOffsetVector: Vector3
## 标称符号
var signInstance: MeshInstance3D


func _init(tag: String, parent: Node = null, offset:Vector3 = Vector3.ZERO) -> void:
	labelInstance = Label3D.new()
	labelInstance.text = tag
	labelInstance.billboard = BaseMaterial3D.BILLBOARD_ENABLED
	
	positionOffsetVector = offset
	signInstance = MeshInstance3D.new()
	var sphereMeshInstance = SphereMesh.new()
	sphereMeshInstance.radius = 0.1
	sphereMeshInstance.height = 0.2
	signInstance.mesh = sphereMeshInstance
	
	if parent != null:
		mount(parent)
	
		
## 将标签挂载到parent
func mount(parent: Node) -> void:
	parent.add_child(labelInstance)
	parent.add_child(signInstance)
	
## 指定位置
func moveTo(position_: Vector3) -> void:
	signInstance.position = position_
	labelInstance.position = position_ + positionOffsetVector
