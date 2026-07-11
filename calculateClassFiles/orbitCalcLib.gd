class_name orbitCalcLib extends RefCounted

## 计算指定时刻的角度
## @experimental: 尚未完成，仅供演示
static func get_angle(orbitData:orbit3d, mu:float, time:float) -> float:
	return time * 2 * PI / 50
## 计算指定时刻焦半径向量
## @experimental: 尚未完成，仅供演示
static func get_vector(orbitData:orbit3d, mu:float, time:float) -> Vector3:
	return orbitData.focusRadius(get_angle(orbitData, mu, time))
