extends ColorRect

@export var max_fps: int = 165

# Called when the node enters the scene tree for the first time.
func _ready():
	visible = false
	pass # Replace with function body.


func _unhandled_input(event):
	if event.is_action_pressed('debug_menu'):
		visible = !visible
		Engine.set_time_scale(0.0 if visible else 1.0)
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE if visible else Input.MOUSE_MODE_CAPTURED)


func _on_spin_box_value_changed(value):
	max_fps = value
	pass # Replace with function body.


func _on_check_button_toggled(button_pressed):
	Engine.set_max_fps(max_fps if button_pressed else 0)
	pass # Replace with function body.
