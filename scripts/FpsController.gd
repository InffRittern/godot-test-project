extends CharacterBody3D


var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
@export var max_speed: float = 10
@export var acceleration: float = 70
@export var friction: float = 60
@export var air_friction: float = 10
@export var jump_impolse: float = 5
@export var mouse_sensitivity: float = .01
@export var controller_sensitivity: float = 3
@export var camera_angle_bottom: float = -45
@export var camera_angle_up: float = 45

#nodes
@onready var head := $Head
@onready var camera := $Head/Camera3D


func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	elif event.is_action_pressed('ui_cancel'):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	if Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
		if event is InputEventMouseMotion:
			head.rotate_y(-event.relative.x * mouse_sensitivity)
			camera.rotate_x(-event.relative.y * mouse_sensitivity)
			
func apply_controller_rotation():
	var axis_vector = Vector2.ZERO
	axis_vector.x = Input.get_action_strength('look_right') - Input.get_action_strength('look_left')
	axis_vector.y = Input.get_action_strength('look_down') - Input.get_action_strength('look_up')
	
	if InputEventJoypadMotion:
		rotate_y(deg_to_rad(-axis_vector.x) * controller_sensitivity)
		head.rotate_x(deg_to_rad(-axis_vector.y) * controller_sensitivity)

func _physics_process(delta):
	var input_vector = get_input_vector()
	var direction = get_direction(input_vector)
	print('input vector', input_vector)
	print('dirction vector', direction)
	apply_movement(direction, delta)
	apply_friction(direction, delta)
	apply_gravity(delta)
	jump()
	apply_controller_rotation()
	head.rotation.x = clamp(head.rotation.x, deg_to_rad(camera_angle_bottom), deg_to_rad(camera_angle_up))
	move_and_slide()
	
	
func get_input_vector():
	var input_vector = Input.get_vector('move_left', 'move_right', 'move_forward', 'move_back')
	return input_vector.normalized() if input_vector.length() > 1 else input_vector
	
func get_direction(input_vector: Vector2):
	var direction = Vector3.ZERO
	direction = (input_vector.x * head.transform.basis.x) + (input_vector.y * head.transform.basis.z)
	return direction.normalized()
	
func apply_movement(direction: Vector3, delta: float):
	if direction != Vector3.ZERO:
		velocity.x = velocity.move_toward(direction * max_speed, acceleration * delta).x
		velocity.z = velocity.move_toward(direction * max_speed, acceleration * delta).z
		
func apply_friction(direction: Vector3, delta: float):
	if direction == Vector3.ZERO:
		if is_on_floor():
			velocity = velocity.move_toward(Vector3.ZERO, friction * delta)
		else:
			velocity.x = velocity.move_toward(Vector3.ZERO, air_friction * delta).x
			velocity.z = velocity.move_toward(Vector3.ZERO, air_friction * delta).z
			
func apply_gravity(delta: float):
	velocity.y += gravity * delta
	velocity.y = clamp(velocity.y, gravity, jump_impolse)
	
	
func jump():
	if Input.is_action_just_pressed('jump') and is_on_floor():
		velocity.y = jump_impolse
	if Input.is_action_just_released('jump') and velocity.y > jump_impolse / 2:
		velocity.y = jump_impolse / 2
	

	
