extends Node

var dim_x := float(0)
var dim_y := float(0)
var dim_z := float(0)


func _init(_dim_x:=float(0), _dim_y:=float(0), _dim_z:=float(0)):
    dim_x = _dim_x
    dim_y = _dim_y
    dim_z = _dim_z


func move(scopes):
    var move_vec := Vector3(dim_x, dim_y, dim_z)
    var newscopes = []
    for scope in scopes:
        var newscope = []
        newscope.append(scope[0]+move_vec)
        newscope.append(scope[1]+move_vec)
        newscope.append(scope[2]+move_vec)
        newscope.append(scope[3]+move_vec)
        newscopes.append(newscope)
    return(newscopes)
