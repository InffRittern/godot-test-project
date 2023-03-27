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
	var ScopeExtraTransforms = preload("res://levels/procedural/scripts/ScopeExtraTransforms.gd")
	var MoveScope = preload("res://levels/procedural/scripts/MoveScope.gd")
	var ExtrudeScope = preload("res://levels/procedural/scripts/ExtrudeScope.gd")
	
	# Load all used modules:
	const underfloor_3x3 := preload("res://environment/modules/underfloor.tscn")
	const SimplePlane_1x1 := preload("res://environment/modules/SimplePlane.tscn")
	const underfloor_3x3_x := int(3)
	const underfloor_3x3_z := int(3)
	const SimplePlane_1x1_x := int(1)
	const SimplePlane_1x1_z := int(1)
	
	# Create arguments for CreateScope
	var scope_1_pos = Vector3(0,0,0)
	var scope_1_dim_x :int = 2
	var scope_1_dim_z :int = 2
	
	var scope_2_pos = Vector3(16,0,8)
	var scope_2_dim_x :int = 8
	var scope_2_dim_z :int = 8
	
	var scope_3_pos = Vector3(0,0,0)
	var scope_3_dim_x :int = 15
	var scope_3_dim_z :int = 33
	
	
	# Create Scopes
	var scopes_1 = CreateScope.new(35).create_scope(scope_1_pos,scope_1_dim_x,scope_1_dim_z)
	var scopes_2 = CreateScope.new().create_scope(scope_2_pos,scope_2_dim_x,scope_2_dim_z)
	var scopes_3 = CreateScope.new(30).create_scope(scope_3_pos,scope_3_dim_x,scope_3_dim_z)
	
	# Move Scopes
	scopes_3 = MoveScope.new(0, -5).move(scopes_3)
	
	
	# Rotate Scopes
	
	var rot_x = RotateScope.new().rotate_scope_x(scopes_3, 0)
	var rev_scope3 = ScopeExtraTransforms.new().reverse_scope(rot_x)
	var rot_y = RotateScope.new().rotate_scope_y(rot_x, 0)

	# Extrude Scopes

	var extruded_3 = ExtrudeScope.new(true).extrude(rot_x, 6)

	
	# Extend scopes array by all scopes
	var scopes = []
	scopes += (scopes_1)
	scopes += (scopes_2)
	
	
	
	
	# Repeat scopes
	var repeat_3_z = RepeatScopes_z.new().repeat_scopes(extruded_3, SimplePlane_1x1_z)
	var repeat_3_z_x = RepeatScopes_x.new().repeat_scopes(repeat_3_z, SimplePlane_1x1_x)
	
	# Fill scopes by procedural meshes
	'var filled_scopes = fill.new().fill_scope(repeat_3_z_x)
	for filled_scope in filled_scopes:
		add_child(filled_scope)
		print(("filled scope - is: "), filled_scope)'
	
	
	# Place modules (Then make children locally in main script)

	var place_module_1 = PlaceModule.new().place_module(repeat_3_z_x, SimplePlane_1x1)
	var seedm := int(0)
	for inst in place_module_1:
		
		seed(seed+seedm)
		seedm +=1
		var r = randf_range(0.01,1)
		var g = randf_range(0.01,1)
		var b = randf_range(0.01,1)
		var color = Color(r,g,b,0.5)
		var mat = StandardMaterial3D.new()
		mat.set_albedo(color)
		mat.transparency = true
		mat.emission = color
		mat.emission_enabled = true
		mat.emission_energy_multiplier = 1
		inst.get_node("MeshInstance3D").set_surface_override_material(0,mat)
		add_child(inst)
	


	# Use ScopeInfo
	print("Scope location is: ", ScopeInfo.new().scope_location(scopes_1))
	print("Scope rotation is: ", ScopeInfo.new().scope_rotation(scopes_1))
	print("Scope dim x is: ", ScopeInfo.new().scope_dim_x((scopes_1)))
	var testrot = (ScopeInfo.new().scope_rotation(scopes_1))[0]
	get_node('test').set_rotation(testrot)


	'	seed(seed)
	if randi_range(1, 100) < 20:
		pass
	var randomized2 = randi_range(1, 100)
	print("randov value now is the: ", randomized)
	print("randov2 value now is the: ", randomized2)'

	print("Base Completed!")
	

func _unhandled_input(event):
	if event.is_action_pressed('generate_level'):
		gen_mesh()


		
func _process(delta):
	

	if update:
		gen_mesh()
		update = false
