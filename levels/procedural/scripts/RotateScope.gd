extends Node


func rotate_scope_x(scopes, rotx):
	var newscopes_x = []
	var rad_rotx = deg_to_rad(rotx)
	for scope in scopes:
		var newscope := PackedVector3Array([
		Vector3(scope[0]),
		Vector3(scope[0] + Vector3(scope[1]-scope[0]).rotated(Vector3(1,0,0), rad_rotx)),
		Vector3(scope[0] + Vector3(scope[2]-scope[0]).rotated(Vector3(1,0,0), rad_rotx)),
		Vector3(scope[0] + Vector3(scope[3]-scope[0]).rotated(Vector3(1,0,0), rad_rotx))
		])
		print(newscope)
		newscopes_x.append(newscope)
		
	return newscopes_x
	
func rotate_scope_y(scopes, roty):
	var newscopes_y = []
	var rad_roty = deg_to_rad(roty)
	for scope in scopes:
		var newscope := PackedVector3Array([
		Vector3(scope[0]),
		Vector3(scope[0] + Vector3(scope[1]-scope[0]).rotated(Vector3(0,1,0), rad_roty)),
		Vector3(scope[0] + Vector3(scope[2]-scope[0]).rotated(Vector3(0,1,0), rad_roty)),
		Vector3(scope[0] + Vector3(scope[3]-scope[0]).rotated(Vector3(0,1,0), rad_roty))
		])
		print(newscope)
		newscopes_y.append(newscope)
		
	return newscopes_y
	
func rotate_scope_z(scopes, rotz):
	var newscopes_z = []
	var rad_rotz = deg_to_rad(rotz)
	for scope in scopes:
		var newscope := PackedVector3Array([
		Vector3(scope[0]),
		Vector3(scope[0] + Vector3(scope[1]-scope[0]).rotated(Vector3(0,0,1), rad_rotz)),
		Vector3(scope[0] + Vector3(scope[2]-scope[0]).rotated(Vector3(0,0,1), rad_rotz)),
		Vector3(scope[0] + Vector3(scope[3]-scope[0]).rotated(Vector3(0,0,1), rad_rotz))
		])
		print(newscope)
		newscopes_z.append(newscope)
		
	return newscopes_z
