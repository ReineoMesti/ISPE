class_name cameraCtrl extends Camera3D

## 摄像机的指向点
@onready var centerPoint: Vector3 = Vector3.ZERO

## 摄像机的指向向量的球面坐标 纬度
@onready var angleVerticalRad: float = 0.0

## 摄像机的指向向量的球面坐标 经度
@onready var angleHorizontalRad: float = 0.0

## 摄像机到中心点的距离
var armDistance: float

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	pass
