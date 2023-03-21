@tool
extends MeshInstance3D

@export var update = false
var st = SurfaceTool.new()


func _ready():
	if Engine.is_editor_hint():
		print("I am in editor! Fuck you asshole!")
		gen_mesh()
	pass
	
func gen_mesh():
	var a_mesh = ArrayMesh.new()
	var vertices := PackedVector3Array([
		Vector3(0,0,0),
		Vector3(1,0,0),
		Vector3(1,0,1),
		]
		)
		
	var indices := PackedInt32Array([
		0,1,2
		
		
		
	])
	
	var array = []
	array.resize(Mesh.ARRAY_MAX)
	array[Mesh.ARRAY_VERTEX] = vertices
	array[Mesh.ARRAY_INDEX] = indices
	a_mesh.add_surface_from_arrays(Mesh.PRIMITIVE_TRIANGLES, array)
	mesh = a_mesh
	pass
	
func _process(delta):
	if update:
		gen_mesh()
		update = false
