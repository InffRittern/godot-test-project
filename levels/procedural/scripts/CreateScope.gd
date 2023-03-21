@tool
extends Node

func create_scope (pos:Vector3, dim_x:int, dim_z:int):
	# Make Arrays:
	var scope := PackedVector3Array([
	Vector3(pos.x,pos.y,pos.z),
	Vector3(pos.x+dim_x,pos.y,pos.z),
	Vector3(pos.x+dim_x,pos.y,pos.z+dim_z),
	Vector3(pos.x,pos.y,pos.z+dim_z)
	])
	return scope
	print("The scope created!")
