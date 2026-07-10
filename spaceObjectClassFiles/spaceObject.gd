class_name spaceObject extends RefCounted

var orbit: orbit3d
var model: shapedObject

func _init(orbitInstance: orbit3d, modelInstance: shapedObject):
	orbit = orbitInstance
	model = modelInstance
