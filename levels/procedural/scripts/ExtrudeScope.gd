extends Node

var reverse := bool()

func _init(_reverse:=bool(false)):
    reverse = _reverse
    


func extrude(scopes, dim):

    var ScopeExtraTransforms = preload("res://levels/procedural/scripts/ScopeExtraTransforms.gd")
    
    var newscope = []
    
    
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
        if reverse:
            bottom = (ScopeExtraTransforms.new().reverse_scope([scope]))[0]
        else:
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
        if reverse:
            newscope = ScopeExtraTransforms.new().reverse_scope(newscope)
    return newscope
