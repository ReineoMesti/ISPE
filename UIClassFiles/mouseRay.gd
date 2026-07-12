extends RayCast3D

var camera: Camera3D
var onCollidingObject: collisionAreaOfSign
var isActive: bool

func _ready() -> void:
	camera = get_parent().get_node("Camera")
	collision_mask = 1
	collide_with_areas = true
	onCollidingObject = null
	isActive = false

func _process(delta):
	if isActive:
		return
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
		if collidingObject is collisionAreaOfSign:
			if collidingObject != onCollidingObject:
				collidingObject.touchedByMouse.emit(spaceObjectDisplay.ONTOUCH_STATUS)
				if onCollidingObject != null:
					onCollidingObject.touchExitedByMouse.emit(spaceObjectDisplay.ONTOUCH_STATUS)
			onCollidingObject = collidingObject
		else:
			if onCollidingObject:
				onCollidingObject.touchExitedByMouse.emit(spaceObjectDisplay.ONTOUCH_STATUS)
			onCollidingObject = null
	else:
		if onCollidingObject:
			onCollidingObject.touchExitedByMouse.emit(spaceObjectDisplay.ONTOUCH_STATUS)
			onCollidingObject = null

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			if event.pressed:
				var mouse_pos = get_viewport().get_mouse_position()
				# 将鼠标位置转换为3D空间中的射线方向
				var ray_origin = camera.project_ray_origin(mouse_pos)
				var ray_normal = camera.project_ray_normal(mouse_pos)
				global_position = ray_origin
				target_position = ray_normal * 1000
				force_raycast_update()
				if is_colliding():
					var collidingObject = get_collider()
					if collidingObject is collisionAreaOfSign:
						collidingObject.clickedByMouse.emit(spaceObjectDisplay.ONCLICK_STATUS)
						if collidingObject != onCollidingObject:
							if onCollidingObject != null:
								onCollidingObject.clickExitedByMouse.emit(spaceObjectDisplay.ONCLICK_STATUS)
						onCollidingObject = collidingObject
						isActive = true
					else:
						if onCollidingObject:
							onCollidingObject.clickExitedByMouse.emit(spaceObjectDisplay.ONCLICK_STATUS)
						onCollidingObject = null
						isActive = false
				else:
					if onCollidingObject:
						onCollidingObject.clickExitedByMouse.emit(spaceObjectDisplay.ONCLICK_STATUS)
						onCollidingObject = null
					isActive = false
				
