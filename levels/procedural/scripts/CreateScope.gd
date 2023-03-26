@tool
extends Node

var x_rot := float(0)
var y_rot := float(0)
var z_rot := float(0)

func _init(_x_rot:=float(0), _y_rot:=float(0), _z_rot:=float(0)):
	x_rot = _x_rot
	y_rot = _y_rot
	z_rot = _z_rot

func create_scope (pos:Vector3, dim_x:int, dim_z:int):
	# Make Arrays:
	var x_rot_rad = deg_to_rad(x_rot)
	var y_rot_rad = deg_to_rad(y_rot)
	var z_rot_rad = deg_to_rad(z_rot)
	var scopes = []
	var scope := PackedVector3Array([
	Vector3(pos.x,pos.y,pos.z).rotated(Vector3(1,0,0), x_rot_rad).rotated(Vector3(0,1,0), y_rot_rad).rotated(Vector3(0,0,1), z_rot_rad),
	Vector3(pos.x+dim_x,pos.y,pos.z).rotated(Vector3(1,0,0), x_rot_rad).rotated(Vector3(0,1,0), y_rot_rad).rotated(Vector3(0,0,1), z_rot_rad),
	Vector3(pos.x+dim_x,pos.y,pos.z+dim_z).rotated(Vector3(1,0,0), x_rot_rad).rotated(Vector3(0,1,0), y_rot_rad).rotated(Vector3(0,0,1), z_rot_rad),
	Vector3(pos.x,pos.y,pos.z+dim_z).rotated(Vector3(1,0,0), x_rot_rad).rotated(Vector3(0,1,0), y_rot_rad).rotated(Vector3(0,0,1), z_rot_rad)
	])
	scopes.append(scope)
	return scopes

