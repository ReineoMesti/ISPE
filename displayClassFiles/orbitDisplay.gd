class_name orbitDisplay extends RefCounted

var meshResource: ImmediateMesh
var nodeInstance: MeshInstance3D
var material: StandardMaterial3D
var activeColor: Color

func _init(parent:Node3D, orbit:Callable, 
	begin:float, end:float, stepCount:int, enclosed:bool, 
	color: Color = Color.GREEN_YELLOW) :
	
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
	material = StandardMaterial3D.new()
	material.vertex_color_use_as_albedo = true
	material.shading_mode = BaseMaterial3D.SHADING_MODE_UNSHADED
	activeColor = color
	material.albedo_color = activeColor
	nodeInstance.material_override = material
	
	if parent != null:
		parent.add_child(nodeInstance)

## 重新指定轨迹颜色
func reassignColor(newColor: Color):
	material.albedo_color = newColor
