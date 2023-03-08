extends ColorRect

@onready var curent_fps := $CenterContainer/PanelContainer/MarginContainer/VBoxContainer/HBoxContainer/Current_fps
@onready var fps_slider := $CenterContainer/PanelContainer/MarginContainer/VBoxContainer/HBoxContainer/HSlider

# Called when the node enters the scene tree for the first time.
func _ready():
	visible = false
	curent_fps.text = 'FPS: ' + str(fps_slider.value)
	pass # Replace with function body.


func _unhandled_input(event):
	if event.is_action_pressed('debug_menu'):
		visible = !visible
		Engine.set_time_scale(0.0 if visible else 1.0)
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE if visible else Input.MOUSE_MODE_CAPTURED)

func _on_h_slider_value_changed(value):
	Engine.set_max_fps(value)
	curent_fps.text = 'FPS: ' + str(value)
