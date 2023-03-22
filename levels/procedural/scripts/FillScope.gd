extends MeshInstance3D

func fill_scope(scopes):
		
	var indices := PackedInt32Array([
		0,1,2,0,2,3
	])
	var first_triangle_mesh = ArrayMesh.new()
	var array = []
	var meshes = []
	var mesh_instances = []
	array.resize(Mesh.ARRAY_MAX)
	array[Mesh.ARRAY_INDEX] = indices
	
	for scope in scopes:
		array[Mesh.ARRAY_VERTEX] = scope
		first_triangle_mesh.add_surface_from_arrays(Mesh.PRIMITIVE_TRIANGLES, array)
		mesh = first_triangle_mesh
		meshes.append(mesh)
	
	for mesh in meshes:
		var mesh_inst = MeshInstance3D.new()
		mesh_inst.mesh = mesh
		mesh_instances.append(mesh_inst)
		print("Procedural mesh instance generated!")
	
	return mesh_instances
