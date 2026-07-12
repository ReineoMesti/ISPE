extends Node3D

@onready var center: MeshInstance3D = $CenterSphere
@onready var camera: Camera3D = $Camera

var ellipse: orbitEllipse
var ship: spaceObjectControl

func _ready() -> void:
	
	camera.global_position = Vector3(6, 4, 0)
	camera.look_at(Vector3(0,0,0))
	center.global_position = Vector3(0,0,0)
	ellipse = orbitEllipse.new(Vector3.UP, Vector3.ZERO, Vector3.FORWARD * 1, Vector3.BACK * 3)
	ship = spaceObjectControl.new("卫星", ellipse, shapedObject.NONE, self, 1, Vector2.DOWN * 60)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
@onready var time = 0
@onready var angle = 0
@onready var flag = true
func _process(delta: float) -> void:
	time += delta * 4
	camera.global_position = Vector3(4,0,0)*cos(angle)+Vector3(0,0,4)*sin(angle)+Vector3(0,3,0)
	camera.look_at(Vector3(0,0,0))
	ship.flush(time)
