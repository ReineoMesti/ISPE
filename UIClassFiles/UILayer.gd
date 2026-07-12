extends CanvasLayer

static var windowTemplate: PackedScene = preload("res://UIClassFiles/orbitInfoWindow.tscn")
var orbitInfoWindowList: Array[Node]
var releasedFlags: Array[bool]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

## 注册Window并返回记录编号(id)
func registerWindow(infoWindow: Window) -> int:
	orbitInfoWindowList.append(infoWindow)
	releasedFlags.append(true)
	return orbitInfoWindowList.size() - 1

## 删除指定编号(id)的窗口
func deleteWindow(id: int) -> void:
	if id >= orbitInfoWindowList.size():
		return
	orbitInfoWindowList[id].queue_free()
	orbitInfoWindowList[id] = null
	releasedFlags[id] = false
	while releasedFlags.back() == false:
		releasedFlags.pop_back()
		orbitInfoWindowList.pop_back()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
