extends Node

func scope_rotation(scopes):
    var basis = Basis()
    # Contains the following default values:
    basis.x = Vector3(1, 0, 0) # Vector pointing along the X axis
    basis.y = Vector3(0, 1, 0) # Vector pointing along the Y axis
    basis.z = Vector3(0, 0, 1) # Vector pointing along the Z axis
    var rotation_array = []
    for scope in scopes:
        var y_vec = (Vector3(scope[3]-scope[0]).normalized()).cross((Vector3(scope[1]-scope[0])).normalized())
        var current_basis = Basis()
        current_basis.x = Vector3(scope[1]-scope[0]).normalized()
        current_basis.y = y_vec.normalized()
        current_basis.z = Vector3(scope[3]-scope[0]).normalized()
        print("angle is: ", current_basis.get_euler())
        rotation_array.append(current_basis.get_euler())
    return rotation_array


func scope_location(scopes):
    var location_array = []
    for scope in scopes:
        location_array.append(scope[0])
    return location_array