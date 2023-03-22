@tool
extends Node


@export var update = false
@export var seed := int(228)


	
func gen_mesh():
	
	# Load custom classes
	var fill = load("res://levels/procedural/scripts/FillScope.gd")
	
	
	# Create arguments for CreateScope
	var scope_1_pos = Vector3(0,0,0)
	var scope_1_dim_x :int = 2
	var scope_1_dim_z :int = 2
	
	var scope_2_pos = Vector3(16,0,8)
	var scope_2_dim_x :int = 8
	var scope_2_dim_z :int = 8
	
	
	# Create Scopes
	var scopes_1 = CreateScope.create_scope(scope_1_pos,scope_1_dim_x,scope_1_dim_z)
	var scopes_2 = CreateScope.create_scope(scope_2_pos,scope_2_dim_x,scope_2_dim_z)
	
	# Extend scopes array by all scopes
	var scopes = []
	scopes += (scopes_1)
	scopes += (scopes_2)
	
	
	# Fill scopes by procedural meshes
	var filled_scopes = fill.new().fill_scope(scopes)
	for filled_scope in filled_scopes:
		add_child(filled_scope)
		print(("filled scope - is: "), filled_scope)
	
	
	###
	const underfloor := preload("res://environment/modules/underfloor.tscn")
	var underfloor_inst = underfloor.instantiate()
	underfloor_inst.set_position(Vector3(3,0,3))
	add_child(underfloor_inst)
	###

	#set position if needed
	#add_child(module_1)
	###
	
	print("Base Completed!")
	
	
func _process(delta):
	if update:
		gen_mesh()
		update = false
