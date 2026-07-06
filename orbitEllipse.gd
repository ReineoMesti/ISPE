class_name orbitEllipse extends orbit3d

var normalVector: Vector3
var majorFocus: Vector3
var periapsisVector: Vector3
var apoapsisVector: Vector3

var completed: bool
var semiMajorAxis: float
var semiMinorAxis: float
var eccentricity: float
var centerVector: Vector3

func _init(normal:Vector3, focus:Vector3, periapsis:Vector3, apoapsis:Vector3) -> void:
	normalVector = normal
	majorFocus = focus
	periapsisVector = periapsis
	apoapsisVector = apoapsis
	semiMajorAxis = (periapsis.length() + apoapsis.length()) / 2.0
	semiMinorAxis = sqrt(periapsis.length() * apoapsis.length())
	eccentricity = (periapsis.length()-apoapsis.length())/(periapsis.length()+apoapsis.length())
	centerVector = periapsis + apoapsis / 2.0
	completed = true
	
func focusRadius(angle_rad:float) -> Vector3:
	var num = semiMajorAxis * (1 - eccentricity*eccentricity)
	var den = 1 - eccentricity * cos(angle_rad)
	var len = num / den
	var unitVectorX = periapsisVector / periapsisVector.length()
	var unitVectorZ = normalVector / normalVector.length()
	var unitVectorY = unitVectorZ.cross(unitVectorX)
	var unitVectorAnswer = unitVectorX * cos(angle_rad) + unitVectorY * sin(angle_rad)
	return unitVectorAnswer * len
func centerRadius(angle_rad:float) -> Vector3:
	var unitVectorX = periapsisVector / periapsisVector.length()
	var unitVectorZ = normalVector / normalVector.length()
	var unitVectorY = unitVectorZ.cross(unitVectorX)
	var answerVector = unitVectorX * semiMajorAxis * cos(angle_rad)
	answerVector += unitVectorY * semiMinorAxis * sin(angle_rad)
	return answerVector
func focusPosition(angle_rad:float) -> Vector3:
	return focusRadius(angle_rad) + majorFocus
func centerPosition(angle_rad:float) -> Vector3:
	return centerRadius(angle_rad) + centerVector + majorFocus
