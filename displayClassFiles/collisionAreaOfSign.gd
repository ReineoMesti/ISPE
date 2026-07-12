class_name collisionAreaOfSign extends Area3D

signal touchedByMouse
signal touchExitedByMouse
signal clickedByMouse
signal clickExitedByMouse
var collisionModel: CollisionShape3D
var radius: float

func _init(touchRadius3D: float = 0.1) -> void:
	radius = touchRadius3D

func _ready() -> void:
	collisionModel = CollisionShape3D.new()
	var sphereCollisionModel = SphereShape3D.new()
	sphereCollisionModel.radius = radius
	collisionModel.shape = sphereCollisionModel
	add_child(collisionModel)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
