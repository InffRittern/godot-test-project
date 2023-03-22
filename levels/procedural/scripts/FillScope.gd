extends MeshInstance3D

func fill_scope(scope:PackedVector3Array):
		
	var indices := PackedInt32Array([
		0,1,2,0,2,3
	])
	var first_triangle_mesh = ArrayMesh.new()
	var array = []
	array.resize(Mesh.ARRAY_MAX)
	array[Mesh.ARRAY_VERTEX] = scope
	array[Mesh.ARRAY_INDEX] = indices
	first_triangle_mesh.add_surface_from_arrays(Mesh.PRIMITIVE_TRIANGLES, array)
	mesh = first_triangle_mesh
	print("Procedural mesh generated!")
	return mesh
