class_name orbitCurve extends RefCounted

var instance: ImmediateMesh

func _init(orbit:Callable, begin:float, end:float, stepCount:int, enclosed:bool) -> void:
	instance = ImmediateMesh.new()
	instance.clear_surfaces()
	instance.surface_set_color(Color.BLUE)
	instance.surface_begin(Mesh.PRIMITIVE_LINE_STRIP)
	var current = begin
	var delta = (end - begin) / float(stepCount)
	instance.surface_add_vertex(orbit.call(current))
	current += delta
	while (begin - current) * (end - current) <= 0:
		instance.surface_add_vertex(orbit.call(current))
		current += delta
	if enclosed:
		instance.surface_add_vertex(orbit.call(begin))
	instance.surface_end()
