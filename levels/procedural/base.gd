@tool
extends Node


@export var update = false
var st = SurfaceTool.new()


	
func gen_mesh():
	var scope_1_pos = Vector3(0,0,0)
	var scope_1_dim_x :int = 2
	var scope_1_dim_z :int = 2
	
	var scope_2_pos = Vector3(16,0,8)
	var scope_2_dim_x :int = 8
	var scope_2_dim_z :int = 8
	
	
	var scope_1 = CreateScope.create_scope(scope_1_pos,scope_1_dim_x,scope_1_dim_z)
	var scope_2 = CreateScope.create_scope(scope_2_pos,scope_2_dim_x,scope_2_dim_z)
	
	var fill = load("res://levels/procedural/scripts/FillScope.gd")
	print(fill)
	var fill_1 = fill.new().fill_scope(scope_1)
	var fill_2 =fill.new().fill_scope(scope_2)
	var mesh_1 = MeshInstance3D.new()
	var mesh_2 = MeshInstance3D.new()
	mesh_1.mesh = fill_1
	mesh_2.mesh = fill_2
	print(("mesh_1 is the: "), mesh_1)
	add_child(mesh_1)
	add_child(mesh_2)
	var children = get_children()
	for child in children:
		print(("child is :"), child)
	#add_child(fill_1)
	
#	add_child(fill_2)
	print(fill_1, fill_2)
	#var mesh1 = FillScope.fill_scope(scope_1)
	#var mesh2 = FillScope.fill_scope(scope_2)
	

	
	
	
	print("Base Completed!")
	pass
	
func _process(delta):
	if update:
		gen_mesh()
		update = false
