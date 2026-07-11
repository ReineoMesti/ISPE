class_name orbitParabola extends orbit3d

## 半通径
var semiLatusRectum: float

func _init(normal: Vector3, focus: Vector3, periapsis: Vector3) -> void:
	# 参数验证
	# assert(periapsis.length() > 0.0, "Periapsis vector cannot be zero")
	# assert(normal.length() > 0.0, "Normal vector cannot be zero")
	normalVector = normal.normalized()
	majorFocus = focus
	periapsisVector = periapsis
	eccentricity = 1.0
	semiLatusRectum = 2.0 * periapsis.length()
	centerVector = Vector3.ZERO

func focusRadius(angle_rad: float) -> Vector3:
	var p = semiLatusRectum
	var den = 1.0 + cos(angle_rad)
	var len_ = p / den if den != 0.0 else INF
	var X = periapsisVector.normalized()
	var Y = normalVector.cross(X)
	var vec = X * cos(angle_rad) + Y * sin(angle_rad)
	return vec * len_


func centerRadius(angle_rad: float) -> Vector3:
	return focusRadius(angle_rad)

func focusPosition(angle_rad: float) -> Vector3:
	return focusRadius(angle_rad) + majorFocus

func centerPosition(angle_rad: float) -> Vector3:
	return centerRadius(angle_rad) + majorFocus
