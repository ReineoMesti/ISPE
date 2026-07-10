class_name spaceObjectDisplay extends RefCounted

## 用于标称名字的标签实例
var labelInstance: Label3D

func _init(tag: String, parent: Node = null) -> void:
	labelInstance = Label3D.new()
	labelInstance.text = tag
	labelInstance.billboard = BaseMaterial3D.BILLBOARD_ENABLED
	if parent != null:
		mount(parent)
		
## 将标签挂载到parent
func mount(parent: Node) -> void:
	parent.add_child(labelInstance)
