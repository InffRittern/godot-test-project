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
@onready var camera := $Head/Camera
@onready var debug := $DebugCamera
@onready var legs_animator : AnimationTree = %LegsAnimationTree
@onready var arms_animator : AnimationTree = $Head/Arms/ArmsAnimationTree


#private

var input_vector := Vector2.ZERO
var player_direction := Vector3.ZERO


func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	legs_animator.set('parameters/conditions/move', true)
	camera.make_current()

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion and Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
		rotate_camera_by_mouse(event, mouse_sensitivity)
	if event.is_action_pressed('debug_cam'):
		if camera.is_current():
			debug.make_current()
		else:
			camera.make_current()
		

func _physics_process(delta):
	get_input_vector()
	get_direction()
	apply_movement(delta)
	apply_friction(delta)
	apply_gravity(delta)
	jump()
	apply_controller_rotation()
	move_and_slide()
	
func apply_controller_rotation():
	var axis_vector = Input.get_vector('look_left', 'look_right', 'look_down', 'look_up')
	if InputEventJoypadMotion:
		rotate_camera_by_gamepad(axis_vector, controller_sensitivity)


func  rotate_camera_by_mouse(input: InputEventMouseMotion, sensitivity: float):
	head.rotate_y(-input.relative.x * sensitivity)
	camera.rotate_x(-input.relative.y * sensitivity)
	var rotate_anim = 0
	if -input.relative.x > 0:
		rotate_anim = -1
	
	if -input.relative.x < 0:
		rotate_anim = 1
	
	if -input.relative.x == 0:
		rotate_anim = 0
	
	legs_animator.set('parameters/Movement/rotate_movement/blend_position', rotate_anim)
	camera.rotation.x = clamp(camera.rotation.x, deg_to_rad(camera_angle_bottom), deg_to_rad(camera_angle_up))
	

func rotate_camera_by_gamepad(input: Vector2, sensitivity: float):
	head.rotate_y(deg_to_rad(-input.x) * sensitivity)
	camera.rotate_x(deg_to_rad(input.y) * sensitivity)
	var rotate_anim = -(input.normalized()).x
	legs_animator.set('parameters/Movement/rotate_movement/blend_position', rotate_anim)
	camera.rotation.x = clamp(camera.rotation.x, deg_to_rad(camera_angle_bottom), deg_to_rad(camera_angle_up))
	
func get_input_vector():
	input_vector = Input.get_vector('move_left', 'move_right', 'move_forward', 'move_back')
	if input_vector.length() > 1:
		input_vector.normalized()
	legs_animator.set('parameters/Movement/move_rotate/current_index', 0 if input_vector == Vector2.ZERO else 1)
	legs_animator.set('parameters/Movement/BaseMovement/blend_position', input_vector)
	
func get_direction():
	var direction = Vector3.ZERO
	direction = (input_vector.x * head.transform.basis.x) + (input_vector.y * head.transform.basis.z)
	player_direction = direction.normalized()
	
func apply_movement(delta: float):
	if player_direction != Vector3.ZERO:
		velocity.x = velocity.move_toward(player_direction * max_speed, acceleration * delta).x
		velocity.z = velocity.move_toward(player_direction * max_speed, acceleration * delta).z
		
func apply_friction(delta: float):
	if player_direction == Vector3.ZERO:
		if is_on_floor():
			velocity = velocity.move_toward(Vector3.ZERO, friction * delta)
			legs_animator.set('parameters/conditions/jump', false)
			legs_animator.set('parameters/conditions/move', true)
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
		legs_animator.set('parameters/conditions/jump', true)
	if Input.is_action_just_released('jump') and velocity.y > jump_impolse / 2:
		velocity.y = jump_impolse / 2

