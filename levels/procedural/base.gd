@tool
extends Node


@export var update = false
@export var seed := int(228)



	
func gen_mesh():
	
	# Load custom classes
	var fill = preload("res://levels/procedural/scripts/FillScope.gd")
	var PlaceModule = preload("res://levels/procedural/scripts/PlaceModule.gd")
	var RepeatScopes_z = preload("res://levels/procedural/scripts/RepeatScopes_z.gd")
	var RepeatScopes_x = preload("res://levels/procedural/scripts/RepeatScopes_x.gd")
	var RotateScope = preload("res://levels/procedural/scripts/RotateScope.gd")
	var ScopeInfo = preload("res://levels/procedural/scripts/ScopeInfo.gd")
	var CreateScope = preload("res://levels/procedural/scripts/CreateScope.gd")
	
	# Load all used modules:
	const underfloor_3x3 := preload("res://environment/modules/underfloor.tscn")
	
	
	# Create arguments for CreateScope
	var scope_1_pos = Vector3(0,0,0)
	var scope_1_dim_x :int = 2
	var scope_1_dim_z :int = 2
	
	var scope_2_pos = Vector3(16,0,8)
	var scope_2_dim_x :int = 8
	var scope_2_dim_z :int = 8
	
	var scope_3_pos = Vector3(0,0,0)
	var scope_3_dim_x :int = 30
	var scope_3_dim_z :int = 30
	
	
	# Create Scopes
	var scopes_1 = CreateScope.new(35).create_scope(scope_1_pos,scope_1_dim_x,scope_1_dim_z)
	var scopes_2 = CreateScope.new().create_scope(scope_2_pos,scope_2_dim_x,scope_2_dim_z)
	var scopes_3 = CreateScope.new().create_scope(scope_3_pos,scope_3_dim_x,scope_3_dim_z)
	
	# Rotate Scopes
	var rot_x = RotateScope.new().rotate_scope_x(scopes_1, 90)
	var rot_y = RotateScope.new().rotate_scope_y(rot_x, 90)
	
	
	# Extend scopes array by all scopes
	var scopes = []
	scopes += (scopes_1)
	scopes += (scopes_2)
	
	
	
	
	# Repeat scopes
	var repeat_3_z = RepeatScopes_z.new().repeat_scopes(scopes_3, 10)
	var repeat_3_z_x = RepeatScopes_x.new().repeat_scopes(repeat_3_z, 10)
	
	# Fill scopes by procedural meshes
	var filled_scopes = fill.new().fill_scope(scopes_1)
	for filled_scope in filled_scopes:
		add_child(filled_scope)
		print(("filled scope - is: "), filled_scope)
	
	
	# Place modules (Then make children locally in main script)
	var place_module_1 = PlaceModule.new().place_module(repeat_3_z_x, underfloor_3x3)
	for inst in place_module_1:
		add_child(inst)
	


	# Use ScopeInfo
	print("Scope location is: ", ScopeInfo.new().scope_location(scopes_1))
	print("Scope rotation is: ", ScopeInfo.new().scope_rotation(scopes_1))
	var testrot = (ScopeInfo.new().scope_rotation(scopes_1))[0]
	get_node('test').set_rotation(testrot)



	print("Base Completed!")
	

func _unhandled_input(event):
	if event.is_action_pressed('generate_level'):
		gen_mesh()


		
func _process(delta):
	

	if update:
		gen_mesh()
		update = false
