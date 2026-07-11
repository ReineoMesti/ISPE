class_name orbitHyperbola extends orbit3d

## 半实轴长
var semiMajorAxis: float
## 半虚轴长
var semiMinorAxis: float

func _init(normal: Vector3, focus: Vector3, periapsis: Vector3, eccentricity_: float) -> void:
	# 验证参数
	# assert(eccentricity > 1.0, "Eccentricity must be > 1 for hyperbola")
	# assert(periapsis.length() > 0.0, "Periapsis vector cannot be zero")
	normalVector = normal / normal.length()
	majorFocus = focus
	periapsisVector = periapsis
	eccentricity = eccentricity_
	semiMajorAxis = periapsis.length() / (eccentricity - 1.0)
	semiMinorAxis = semiMajorAxis * sqrt(eccentricity * eccentricity - 1.0)
	centerVector = Vector3.ZERO

func focusRadius(angle_rad: float) -> Vector3:
	var p = semiMajorAxis * (eccentricity * eccentricity - 1.0)
	var den = 1.0 + eccentricity * cos(angle_rad)
	var len_ = p / den
	var X = periapsisVector / periapsisVector.length()
	var Y = normalVector.cross(X)
	var vec = X * cos(angle_rad) + Y * sin(angle_rad)
	return vec * len_


func centerRadius(angle_rad: float) -> Vector3:
	return focusRadius(angle_rad)

func focusPosition(angle_rad: float) -> Vector3:
	return focusRadius(angle_rad) + majorFocus

func centerPosition(angle_rad: float) -> Vector3:
	return focusPosition(angle_rad)
