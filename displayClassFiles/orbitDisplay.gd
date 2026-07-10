class_name orbitDisplay extends RefCounted

var meshResource: ImmediateMesh
var nodeInstance: MeshInstance3D

func _init(orbit:Callable, begin:float, end:float, stepCount:int, enclosed:bool) -> void:
	meshResource = ImmediateMesh.new()
	meshResource.clear_surfaces()
	meshResource.surface_set_color(Color.BLUE)
	meshResource.surface_begin(Mesh.PRIMITIVE_LINE_STRIP)
	var current = begin
	var delta = (end - begin) / float(stepCount)
	meshResource.surface_add_vertex(orbit.call(current))
	current += delta
	while (begin - current) * (end - current) <= 0:
		meshResource.surface_add_vertex(orbit.call(current))
		current += delta
	if enclosed:
		meshResource.surface_add_vertex(orbit.call(begin))
	meshResource.surface_end()
	nodeInstance = MeshInstance3D.new()
	nodeInstance.mesh = meshResource
