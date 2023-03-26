extends Node

func reverse_scope(scopes):
    var newscopes = []
    for scope in scopes:
        var newscope = []
        newscope.append(scope[3])
        newscope.append(scope[2])
        newscope.append(scope[1])
        newscope.append(scope[0])
        newscopes.append(newscope)
    return newscopes