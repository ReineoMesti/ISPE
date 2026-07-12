class_name spaceObjectDisplay extends RefCounted

static var onClickFontColor = Color.GREEN
static var normalFontColor = Color.WHITE
static var onTouchFontColor = Color.GREEN_YELLOW

## 用于标称名字的标签实例
var labelInstance: Label3D
## 用于设置文本悬停高度的向量，一般需要是Vector3.UP正向的
var positionOffsetVector: Vector2

## 标称符号的半径取值
const signRadius = 0.1

## 标称符号
var signInstance: MeshInstance3D
## 标称符号的物理区域
var signArea: Area3D
## 轨道显示
var orbitDisplayInstance: orbitDisplay

const NORMAL_STATUS = 0
const ONTOUCH_STATUS = 1
const ONCLICK_STATUS = 2

## 状态
var status: int


func _init(tag: String, displayedOrbit: orbitDisplay, parent: Node = null, offset:Vector2 = Vector2.ZERO) -> void:
	labelInstance = Label3D.new()
	labelInstance.text = tag
	labelInstance.billboard = BaseMaterial3D.BILLBOARD_ENABLED
	
	positionOffsetVector = offset
	labelInstance.offset = positionOffsetVector
	signInstance = MeshInstance3D.new()
	var sphereMeshInstance = SphereMesh.new()
	sphereMeshInstance.radius = signRadius
	sphereMeshInstance.height = signRadius * 2
	signInstance.mesh = sphereMeshInstance
	orbitDisplayInstance = displayedOrbit
	signArea = collisionAreaOfSign.new(signRadius)
	signInstance.add_child(signArea)
	status = NORMAL_STATUS
	
	signArea.collision_layer = 1
	signArea.touchedByMouse.connect(collisionProcessor)
	signArea.touchExitedByMouse.connect(collisionRecoverProcessor)
	appearanceNormal()
	if parent != null:
		mount(parent)
	
		
## 将标签挂载到parent
func mount(parent: Node) -> void:
	parent.add_child(labelInstance)
	parent.add_child(signInstance)
	parent.add_child(orbitDisplayInstance.nodeInstance)
	orbitDisplayInstance.nodeInstance.hide()
	
## 指定位置
func moveTo(position_: Vector3) -> void:
	signInstance.position = position_
	labelInstance.position = position_

func collisionProcessor(signalType: int):
	if signalType == ONTOUCH_STATUS:
		appearanceOnTouch()
	elif signalType == ONCLICK_STATUS:
		appearanceOnClick()
func collisionRecoverProcessor(signalType: int):
	if status == signalType:
		appearanceNormal()

func appearanceOnTouch() -> void:
	orbitDisplayInstance.nodeInstance.show()
	status = ONTOUCH_STATUS
	labelInstance.modulate = onTouchFontColor

func appearanceOnClick() -> void:
	status = ONCLICK_STATUS
	labelInstance.modulate = onClickFontColor
	
func appearanceNormal() -> void:
	orbitDisplayInstance.nodeInstance.hide()
	labelInstance.modulate = normalFontColor
	status = NORMAL_STATUS
	
