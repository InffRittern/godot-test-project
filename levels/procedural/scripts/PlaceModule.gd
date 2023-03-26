extends Node


func place_module(scopes, module):
	var ScopeInfo = preload("res://levels/procedural/scripts/ScopeInfo.gd")
	var module_instances = []
	for scope in scopes:
		var module_inst = module.instantiate()
		var mod_pos := Vector3(scope[0])
		var arrayed_scope = []
		arrayed_scope.append(scope)
		var scope_rot = Vector3(ScopeInfo.new().scope_rotation(arrayed_scope)[0])
		module_inst.set_position(mod_pos)
		module_inst.set_rotation(scope_rot)
		module_instances.append(module_inst)
		arrayed_scope = []
	return module_instances
	
	


