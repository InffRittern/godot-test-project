extends Node


func extrude(scopes, dim):
    
    var newscope = []
    var newscopes = []
    
    var top := PackedVector3Array([])
    var bottom := PackedVector3Array([])
    var front := PackedVector3Array([])
    var back := PackedVector3Array([])
    var left := PackedVector3Array([])
    var right := PackedVector3Array([])

    for scope in scopes:
        var dimvec := Vector3((scope[3]-scope[0]).normalized()).cross((Vector3(scope[1]-scope[0])).normalized()*dim)
        top = [
            scope[0]+dimvec,
            scope[1]+dimvec,
            scope[2]+dimvec,
            scope[3]+dimvec
        ]
        newscope.append(top)
        bottom = scope
        newscope.append(bottom)
        front = [
            scope[0],
            scope[0]+dimvec,
            scope[3]+dimvec,
            scope[3]
        ]
        newscope.append(front)
        back = [
            scope[2],
            scope[2]+dimvec,
            scope[1]+dimvec,
            scope[1]
        ]
        newscope.append(back)
        left = [
            scope[1],
            scope[1]+dimvec,
            scope[0]+dimvec,
            scope[0]
        ]
        newscope.append(left)
        right = [
            scope[3],
            scope[3]+dimvec,
            scope[2]+dimvec,
            scope[2]
        ]
        newscope.append(right)
    return newscope
