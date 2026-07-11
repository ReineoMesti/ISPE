@abstract class_name orbit3d extends RefCounted

## 轨道的法向量，按照右手螺旋的规则同时也指定了物体的运动方向
var normalVector: Vector3
## 中心天体的位置
var majorFocus: Vector3
## 从中心天体指向近拱点的向量
var periapsisVector: Vector3

## 偏心率
var eccentricity: float
## 从中心天体指向轨道的几何中心的向量，该参数与轨道的绘制有关
var centerVector: Vector3

@abstract func _init()
@abstract func focusRadius(angle_rad:float) -> Vector3
@abstract func centerRadius(angle_rad:float) -> Vector3

@abstract func focusPosition(angle_rad:float) -> Vector3
@abstract func centerPosition(angle_rad:float) -> Vector3
