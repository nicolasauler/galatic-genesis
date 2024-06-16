extends RigidBody3D

@export_category("Nodes")
@export var _camera: Camera3d
@export var _camera_pivot: Node3D
@export var _ground_cast: RayCast3D

var is_grounded: bool:
	get:
		return _ground_cast.is_colliding()
		
var _ground: Planet:
	get:
		return _ground_cast.get_collider() as Planet

var _surface_position: Vector3
var _is_stuck_to_surface: bool

@export_category("Settings")
@export var _mouse_sensitivity: float = 0.3
var _mouse_delta: Vector2 = Vector2.ZERO
var _camera_x_rotation: float = 0.0

@export var _thrust: float = 1.0
@export var _auto_orient_speed: float = 0.5
@export var _jump_impulse: float = 5.0

var _in_map: bool = false

func _ready():
	show_map(false)

func _process(delta: float):
	if Input.is_action_just_released("Map"):
		show_map(not _in_map)

func process_movement_inputs(delta: float):
	var movement = Vector3.ZERO

	var forward = -global_transform.basis.z
	var left = -global_transform.basis.x
	var up = global_transform.basis.y

	if Input.is_action_pressed("Forward"):
		movement += forward
	if Input.is_action_pressed("Backward"):
		movement -= forward
	if Input.is_action_pressed("Left"):
		movement += left
	if Input.is_action_pressed("Right"):
		movement -= left
	if Input.is_action_pressed("Up"):
		movement += up
	if Input.is_action_pressed("Down"):
		movement -= up

	var should_stick_to_surface = movement == Vector3.ZERO and _ground and _ground.get_relative_velocity_to_surface(global_position, linear_velocity).length() < 0.2

	if should_stick_to_surface:
		if _is_stuck_to_surface:
			global_position = _ground.to_global(_surface_position)
		else:
			_surface_position = _ground.to_local(global_position)
			_is_stuck_to_surface = true
	else:
		_is_stuck_to_surface = false

	if movement != Vector3.ZERO:
		apply_central_force(_thrust * movement.normalized())

	if is_grounded and Input.is_action_just_released("Jump"):
		apply_central_impulse(_jump_impulse * up)

func process_look_inputs(delta: float):
	var delta_x = _mouse_delta.y * _mouse_sensitivity
	var delta_y = -_mouse_delta.x * _mouse_sensitivity

	if Input.is_action_pressed("Rotate"):
		rotate(_camera_pivot.global_transform.basis.z, deg_to_rad(delta_y))
	else:
		rotate_object_local(Vector3.UP, deg_to_rad(delta_y))
		if _camera_x_rotation + delta_x > -90 and _camera_x_rotation + delta_x < 90:
			_camera_pivot.rotate_x(deg_to_rad(-delta_x))
			_camera_x_rotation += delta_x

func process_auto_orientation(delta: float):
	angular_velocity = Vector3.ZERO
	angular_damp = 10

	var in_zero_g = _closest_force == Vector3.ZERO

	if in_zero_g:
		var dx = lerp(0, -_camera_x_rotation, _auto_orient_speed * delta)
		_camera_x_rotation += dx

		_camera_pivot.rotate_x(deg_to_rad(-dx))
		rotate(_camera_pivot.global_transform.basis.x, deg_to_rad(dx))
	else:
		var up_direction = -_closest_force.normalized()
		var orientation_direction = Quaternion(global_transform.basis.y, up_direction) * global_transform.basis.get_rotation_quaternion()

		if is_grounded:
			angular_velocity = _ground.constant_angular_velocity.project(up_direction)
			angular_damp = 0
			global_rotation = orientation_direction.normalized().get_euler()
		else:
			var rotation = global_transform.basis.get_rotation_quaternion().slerp(orientation_direction.normalized(), _auto_orient_speed * delta)
			global_rotation = rotation.get_euler()

func _input(event: InputEvent):
	if event is InputEventMouseMotion:
		var mouse_motion = event as InputEventMouseMotion
		_mouse_delta += mouse_motion.relative

func show_map(in_map: bool):
	_in_map = in_map

	if _in_map:
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
		_camera.current = false
	else:
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
		_camera.current = true
