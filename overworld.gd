extends Node3D

@onready var center: MeshInstance3D = $CenterSphere
@onready var camera: Camera3D = $Camera

var ellipse: orbitEllipse
var ship: spaceObjectControl
var curve: orbitDisplay

func _ready() -> void:
	
	camera.global_position = Vector3(6, 4, 0)
	camera.look_at(Vector3(0,0,0))
	center.global_position = Vector3(0,0,0)
	ellipse = orbitEllipse.new(Vector3.UP, Vector3.ZERO, Vector3.FORWARD * 1, Vector3.BACK * 3)
	ship = spaceObjectControl.new("卫星", ellipse, shapedObject.NONE, self, 1, Vector3.UP * 0.4)
	curve = orbitDisplay.new(self, ellipse.centerPosition, 0, 2*PI, 30, true)
	
	var material = StandardMaterial3D.new()
	material.vertex_color_use_as_albedo = true
	material.shading_mode = BaseMaterial3D.SHADING_MODE_UNSHADED
	curve.nodeInstance.material_override = material
	
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
@onready var time = 0
@onready var angle = 0
@onready var flag = true
func _process(delta: float) -> void:
	time += delta * 4
	camera.global_position = Vector3(4,0,0)*cos(angle)+Vector3(0,0,4)*sin(angle)+Vector3(0,3,0)
	camera.look_at(Vector3(0,0,0))
	ship.flush(time)
