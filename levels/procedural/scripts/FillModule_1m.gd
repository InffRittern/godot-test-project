extends Node

var PlaceModule = preload("res://levels/procedural/scripts/PlaceModule.gd")
var ScopeInfo = preload("res://levels/procedural/scripts/ScopeInfo.gd")

func fill_module(scopes, module):
	var filled_modules = []
	for scope in scopes:
		var tempscopes = [scope]
		var placed_module = PlaceModule.new().place_module(tempscopes, module)
		var scale := Vector3(ScopeInfo.new().scope_dim_x(tempscopes)[0],1,ScopeInfo.new().scope_dim_z(tempscopes)[0])
		placed_module[0].set_scale(scale)

		filled_modules.append(placed_module[0])
	return filled_modules

	

