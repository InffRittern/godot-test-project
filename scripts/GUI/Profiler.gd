extends CanvasLayer


@onready var debug_list := $DEBUG
@onready var fps := $DEBUG/fps
@onready var memory := $DEBUG/memory

# Called when the node enters the scene tree for the first time.
func _ready():
	visible = false
	pass # Replace with function body.
	
func _unhandled_input(event):
	if event.is_action_pressed('performance'):
		visible = !visible


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var _erlaps_time = delta
	fps.text = 'FPS: ' + str(Performance.get_monitor(Performance.TIME_FPS))
	memory.text = 'Memory static: ' + str(round(Performance.get_monitor(Performance.MEMORY_STATIC)/1024/1024)) + ' MB'

