class_name orbitCalcLib extends RefCounted

## 计算指定时刻的角度
## @experimental: 尚未完成，仅供演示
static func get_angle(orbitData:orbit3d, mu:float, time:float) -> float:
	var ellipse: orbitEllipse = orbitData as orbitEllipse
	var a = ellipse.semiMajorAxis
	var e = ellipse.eccentricity
	
	# 计算平均角速度 (开普勒第三定律)
	var n = sqrt(mu / (a * a * a))
	
	# 平近点角
	var M = n * time
	
	# 解开普勒方程: M = E - e * sin(E)   (用牛顿迭代法)
	var E = M  # 初始猜测
	for i in range(10):  # 迭代10次足够
		var dE = (M - (E - e * sin(E))) / (1 - e * cos(E))
		E += dE
		if abs(dE) < 1e-8:
			break
	
	# 真近点角 (从近拱点开始计算的角度)
	var theta = 2 * atan2(sqrt(1 + e) * sin(E / 2), sqrt(1 - e) * cos(E / 2))
	
	return theta
## 计算指定时刻焦半径向量
## @experimental: 尚未完成，仅供演示
static func get_vector(orbitData:orbit3d, mu:float, time:float) -> Vector3:
	return orbitData.focusRadius(get_angle(orbitData, mu, time))
