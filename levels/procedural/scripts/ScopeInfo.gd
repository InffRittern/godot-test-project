extends Node

func scope_rotation(scopes):
    var rotation_y_array = []
    for scope in scopes:
        var ang = Vector3(scope[3]-scope[0]).normalized().angle_to(Vector3(0,0,1))
        print(ang)

    return rotation_y_array


func scope_location(scopes):
    var location_array = []
    for scope in scopes:
        location_array.append(scope[0])
    return location_array