@tool
extends Node


@export var update = false
var st = SurfaceTool.new()


	
func gen_mesh():
	var scope_1_pos = Vector3(0,0,0)
	var scope_1_dim_x :int = 2
	var scope_1_dim_z :int = 2
	
	var scope_2_pos = Vector3(4,0,4)
	var scope_2_dim_x :int = 1
	var scope_2_dim_z :int = 1
	
	
	var scope_1 = CreateScope.create_scope(scope_1_pos,scope_1_dim_x,scope_1_dim_z)
	var scope_2 = CreateScope.create_scope(scope_2_pos,scope_2_dim_x,scope_2_dim_z)
	var mesh1 = FillScope.fill_scope(scope_1)
	var mesh2 = FillScope.fill_scope(scope_2)
	

	
	
	
	print("Base Completed!")
	pass
	
func _process(delta):
	if update:
		gen_mesh()
		update = false
