extends Node3D

@onready var center: MeshInstance3D = $CenterSphere
@onready var camera: Camera3D = $Camera
var ellipse: orbitEllipse
var curve: orbitDisplay
var material:StandardMaterial3D

func _ready() -> void:
	camera.global_position = Vector3(6, 4, 0)
	camera.look_at(Vector3(0,0,0))
	center.global_position = Vector3(0,0,0)
	ellipse = orbitEllipse.new(Vector3(0,1,1), Vector3(0,0,0), Vector3(1,0,0), Vector3(-3,0,0))
	curve = orbitDisplay.new(ellipse.centerPosition, 0, 2 * PI, 60, true)
	
	material = StandardMaterial3D.new()
	material.emission_enabled = true
	material.albedo_color = Color.AQUA
	curve.nodeInstance.material_overlay = material
	add_child(curve.nodeInstance)
	curve.nodeInstance.global_position = Vector3.ZERO
	
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
@onready var angle = 0

func _process(delta: float) -> void:
	angle += delta / 3
	camera.global_position = Vector3(6,0,0)*cos(angle)+Vector3(0,0,6)*sin(angle)+Vector3(0,4,0)
	camera.look_at(Vector3(0,0,0))
	pass
