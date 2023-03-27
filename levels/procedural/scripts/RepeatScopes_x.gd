extends Node


func repeat_scopes(scopes, dim_x):
	var scopes_new = []
	var z_plus := int(0)
	var new_scopes = []
	for scope in scopes:
		var new_scope_zero := PackedVector3Array([])
		var base_scope_len = (scope[1] - scope[0]).length()
		var splited_scope_len = (scope[1] - scope[0]).normalized()*dim_x
		var count := int(roundf(base_scope_len/dim_x))
		print("for", base_scope_len, "count x is:", count)
		for i in range(count):
			if i < 1:
				new_scope_zero.append(scope[0])
				new_scope_zero.append(scope[0]+splited_scope_len)
				new_scope_zero.append(scope[3]+splited_scope_len)
				new_scope_zero.append(scope[3])
				new_scopes.append(new_scope_zero)
			else:
				var new_scope = []
				var last_scope = new_scopes[-1]
				for vec in last_scope:
					new_scope.append(Vector3(vec+splited_scope_len))
				new_scopes.append(new_scope)
	return new_scopes
