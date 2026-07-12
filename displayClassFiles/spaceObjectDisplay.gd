class_name spaceObjectDisplay extends RefCounted

static var onClickFontColor = Color.GREEN
static var normalFontColor = Color.WHITE
static var onTouchFontColor = Color.GREEN_YELLOW

static var infoWindowTemplate: PackedScene = preload("res://UIClassFiles/orbitInfoWindow.tscn")

static var normalFontSize = 32
static var onClickFontSize = 42
static var onTouchFontSize = 38

## 用于标称名字的标签实例
var labelInstance: Label3D
## 用于设置文本悬停高度的向量，一般需要是Vector2.UP正向的
var positionOffsetVector: Vector2

## 标称符号的半径取值
const signRadius = 0.1

## 标称符号
var signInstance: MeshInstance3D
## 标称符号的物理区域
var signArea: Area3D
## 轨道显示
var orbitDisplayInstance: orbitDisplay

## 用于放置轨道参数小窗的实例
var uiLayerInstance: CanvasLayer
## 轨道参数显示小窗的实例
var infoWindow: orbitInfoWindow

## 相机实例
var cameraInstance: Camera3D

const NORMAL_STATUS = 0
const ONTOUCH_STATUS = 1
const ONCLICK_STATUS = 2

## 状态，可以在0, 1, 2取一个
var status: int


func _init(tag: String, displayedOrbit: orbitDisplay, uiLayer: CanvasLayer, camera: Camera3D, parent: Node3D = null
	, offset:Vector2 = Vector2.ZERO):
	uiLayerInstance = uiLayer
	infoWindow = null
	labelInstance = Label3D.new()
	labelInstance.text = tag
	labelInstance.billboard = BaseMaterial3D.BILLBOARD_ENABLED
	cameraInstance = camera
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
	
	signArea.clickedByMouse.connect(collisionProcessor)
	signArea.clickExitedByMouse.connect(collisionRecoverProcessor)
	appearanceNormal()
	if parent != null:
		mount(parent)
	
		
## 将标签挂载到parent
func mount(parent: Node) -> void:
	parent.add_child(labelInstance)
	parent.add_child(signInstance)
	parent.add_child(orbitDisplayInstance.nodeInstance)
	orbitDisplayInstance.nodeInstance.hide()

## 重新指定轨道参数窗口内容
func reassignInfoWindowText(text: String) -> void:
	if infoWindow and is_instance_valid(infoWindow):
		infoWindow.reassignText(text)

## 移动至指定位置
func moveTo(position_: Vector3) -> void:
	signInstance.position = position_
	labelInstance.position = position_
	if infoWindow and is_instance_valid(infoWindow):
		# ! 没有clamp
		infoWindow.position = cameraInstance.unproject_position(signInstance.global_position)
		# ! 该值取决于Margin
		infoWindow.position += Vector2i(10,10)
	

func collisionProcessor(signalType: int):
	if signalType == ONTOUCH_STATUS:
		appearanceOnTouch()
	elif signalType == ONCLICK_STATUS:
		appearanceOnClick()
func collisionRecoverProcessor(signalType: int):
	if status == signalType:
		appearanceNormal()

## 切换至受到鼠标悬停的状态
func appearanceOnTouch() -> void:
	orbitDisplayInstance.nodeInstance.show()
	status = ONTOUCH_STATUS
	labelInstance.modulate = onTouchFontColor
	labelInstance.font_size = onTouchFontSize
## 切换至受到鼠标点击而选中的状态
func appearanceOnClick() -> void:
	appearanceNormal()
	orbitDisplayInstance.nodeInstance.show()
	status = ONCLICK_STATUS
	labelInstance.modulate = onClickFontColor
	labelInstance.font_size = onClickFontSize
	if infoWindow == null:
		infoWindow = infoWindowTemplate.instantiate()
		uiLayerInstance.add_child(infoWindow)
## 切换至正常状态
func appearanceNormal() -> void:
	orbitDisplayInstance.nodeInstance.hide()
	labelInstance.modulate = normalFontColor
	labelInstance.font_size = normalFontSize
	status = NORMAL_STATUS
	if infoWindow and is_instance_valid(infoWindow):
		infoWindow.queue_free()
		infoWindow = null
	
