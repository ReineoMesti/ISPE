extends RayCast3D

var camera: Camera3D
var onCollidingObject: Area3D

func _ready() -> void:
	camera = get_parent().get_node("Camera")
	collision_mask = 1
	collide_with_areas = true
	onCollidingObject = null
	
func _process(delta):
	# 获取鼠标在屏幕上的位置
	var mouse_pos = get_viewport().get_mouse_position()
	# 将鼠标位置转换为3D空间中的射线方向
	var ray_origin = camera.project_ray_origin(mouse_pos)
	var ray_normal = camera.project_ray_normal(mouse_pos)
	
	global_position = ray_origin
	target_position = ray_normal * 1000
	force_raycast_update()
	if is_colliding():
		var collidingObject = get_collider()
		if collidingObject is Area3D:
			if collidingObject != onCollidingObject:
				collidingObject.body_entered.emit()
				if onCollidingObject != null:
					onCollidingObject.body_exited.emit()
		else:
			if onCollidingObject:
				onCollidingObject.body_exited.emit()
		onCollidingObject = collidingObject
	else:
		if onCollidingObject:
			onCollidingObject.body_exited.emit()
			onCollidingObject = null
