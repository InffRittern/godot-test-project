extends CharacterBody3D


@export var max_speed: float = 10
@export var acceleration: float = 70
@export var friction: float = 60
@export var air_friction: float = 10
@export var jump_impolse: float = 5
@export_range(0.001, 1, 0.001) var mouse_sensitivity: float = 0.001
@export var controller_sensitivity: float = 3
@export var camera_angle_bottom: float = -90
@export var camera_angle_up: float = 90
@export_range(0, 100, 0.5) var gravity: float = 9.8

#nodes
@onready var head := $Head
@onready var camera := $Head/Camera3D
@onready var legs_animator : AnimationTree = $Head/Legs/LegsAnimationTree
@onready var arms_animator : AnimationTree = $Head/Arms/ArmsAnimationTree

var rotate_angle: float = 0


func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion and Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
		rotate_camera(event.relative, mouse_sensitivity)

func _physics_process(delta):
	var input_vector = get_input_vector()
	var direction = get_direction(input_vector)
	apply_animation(input_vector)
	apply_movement(direction, delta)
	apply_friction(direction, delta)
	apply_gravity(delta)
	jump()
	apply_controller_rotation()
	
	move_and_slide()
	
func apply_controller_rotation():
	var axis_vector = Input.get_vector('look_left', 'look_right', 'look_down', 'look_up')
	if InputEventJoypadMotion:
		rotate_camera(axis_vector, controller_sensitivity, true)
		
		
func rotate_camera(input: Vector2, sensitivity: float, is_gamepad: bool = false):
	var angle_befor = head.rotation.y
	if is_gamepad:
		head.rotate_y(deg_to_rad(-input.x) * sensitivity)
		camera.rotate_x(deg_to_rad(input.y) * sensitivity)
	else:
		head.rotate_y(-input.x * sensitivity)
		camera.rotate_x(-input.y * sensitivity)
	camera.rotation.x = clamp(camera.rotation.x, deg_to_rad(camera_angle_bottom), deg_to_rad(camera_angle_up))
	head.rotate.y = wrapf(head.rotate.y, 0, 360)
	rotate_angle = head.rotation.y - angle_befor
	
	
	
func get_input_vector() -> Vector2:
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
	# TODO gravity hack need fix
	velocity.y += -gravity * delta
	velocity.y = clamp(velocity.y, -gravity, jump_impolse)
	
func jump():
	if Input.is_action_just_pressed('jump') and is_on_floor():
		velocity.y = jump_impolse
	if Input.is_action_just_released('jump') and velocity.y > jump_impolse / 2:
		velocity.y = jump_impolse / 2

func apply_animation(input: Vector2):
	legs_animator.set('parameters/move_rotation_transition/current_index', 0 if input == Vector2.ZERO else 1)
	legs_animator.set('parameters/Rotating/blend_position', rotate_angle)
	legs_animator.set('parameters/Movement/blend_position', input)
	legs_animator.set('parameters/OneShot/request', !is_on_floor())
	print('rotate angle: ', rotate_angle)
	

	
