extends Node


func place_module(scopes, module):
	var module_instances = []
	for scope in scopes:
		var module_inst = module.instantiate()
		var mod_pos := Vector3(scope[0])
		module_inst.set_position(mod_pos)
		module_instances.append(module_inst)
	return module_instances
	
	


