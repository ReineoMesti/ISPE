class_name spaceObjectDisplay extends RefCounted

static var onClickFontColor = Color.GREEN
static var normalFontColor = Color.WHITE
static var onTouchFontColor = Color.GREEN_YELLOW

## 用于标称名字的标签实例
var labelInstance: Label3D
## 用于设置文本悬停高度的向量，一般需要是Vector3.UP正向的
var positionOffsetVector: Vector3

## 标称符号的半径取值
const signRadius = 0.1

## 标称符号
var signInstance: MeshInstance3D
## 标称符号的物理区域
var signArea: Area3D
## 标称符号的物理碰撞体
var signCollision: CollisionShape3D
## 发生点击的信号
signal onClick


const NORMAL_STATUS = 0
const ONTOUCH_STATUS = 1
const ONCLICK_STATUS = 2

## 状态
var status: int


func _init(tag: String, parent: Node = null, offset:Vector3 = Vector3.ZERO) -> void:
	labelInstance = Label3D.new()
	labelInstance.text = tag
	labelInstance.billboard = BaseMaterial3D.BILLBOARD_ENABLED
	
	positionOffsetVector = offset
	signInstance = MeshInstance3D.new()
	var sphereMeshInstance = SphereMesh.new()
	sphereMeshInstance.radius = signRadius
	sphereMeshInstance.height = signRadius * 2
	signInstance.mesh = sphereMeshInstance
	
	signArea = Area3D.new()
	signCollision = CollisionShape3D.new()
	signCollision.shape = SphereShape3D.new()
	signCollision.shape.radius = signRadius
	signArea.add_child(signCollision)
	signInstance.add_child(signArea)
	status = NORMAL_STATUS
	appearanceNormal()
	signArea.collision_layer = 1
	signArea.body_entered.connect(collisionProcessor)
	signArea.body_exited.connect(collisionRecoverProcessor)
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

func collisionProcessor():
	appearanceOnTouch()
func collisionRecoverProcessor():
	appearanceNormal()

func appearanceOnTouch() -> void:
	status = ONTOUCH_STATUS
	labelInstance.modulate = onTouchFontColor
	#labelInstance.font_size += 4

func appearanceOnClick() -> void:
	status = ONCLICK_STATUS
	labelInstance.modulate = onClickFontColor
	
func appearanceNormal() -> void:
	labelInstance.modulate = normalFontColor
	#labelInstance.font_size -= 4
	status = NORMAL_STATUS
	
