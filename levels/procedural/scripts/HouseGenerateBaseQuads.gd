extends Node

var CreateScope = preload("res://levels/procedural/scripts/CreateScope.gd")

func generate_quads(area, minlen, seed):
	var seedm := int(1)
	seed(seed)
	var scopes = []
	var quad_count = randi_range(3,6)
	var base_scope_pos := Vector3(0,0,0)
	var changed_center : int
	var excluded_center : int

	

	for count in range(quad_count):
		seed(seed+seedm)
		var base_scope_dim_x = randi_range(minlen*2,24)
		var base_scope_dim_z = randi_range(minlen*2,24)
		base_scope_pos = base_scope_pos - Vector3(base_scope_dim_x/2, 0, base_scope_dim_z/2)
		var base_scope = CreateScope.new().create_scope(base_scope_pos,base_scope_dim_x,base_scope_dim_z)
		var center_0 := Vector3(int((base_scope[-1][0]).x+(base_scope_dim_x/2)), 0, int((base_scope[-1][0]).z))
		var center_1 := Vector3(int((base_scope[-1][0]).x+base_scope_dim_x), 0 , int((base_scope[-1][0]).z+(base_scope_dim_z/2)))
		var center_2 := Vector3(int((base_scope[-1][0]).x+(base_scope_dim_x/2)), 0, int((base_scope[-1][0]).z+base_scope_dim_z))
		var center_3 := Vector3(int((base_scope[-1][0]).x), 0, int((base_scope[-1][0]).z+(base_scope_dim_z/2)))
		
		changed_center = randi_range(0,3)
		while changed_center == excluded_center:
			seedm +=1
			seed(seed+seedm)
			changed_center = randi_range(0,3)





		if changed_center == 0:
			base_scope_pos = center_0
			excluded_center = 2	
		elif changed_center == 1:
			base_scope_pos = center_1
			excluded_center = 3
		elif changed_center == 2:
			base_scope_pos = center_2
			excluded_center = 0	
		elif changed_center == 3:
			base_scope_pos = center_3
			excluded_center = 1
		
		seedm += 1
		scopes += base_scope

	return scopes
