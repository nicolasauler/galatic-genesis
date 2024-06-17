extends CharacterBody3D

# How fast the player moves in meters per second.
@export var speed = 500

@onready var camera = $CameraPivot/Camera3D

var _direction = Vector3.ZERO

var target_velocity = Vector3.ZERO

func _ready():
	pass
	#Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _process(delta):
	_physics_process(delta)
	
func _physics_process(delta):
	var direction = Vector3.ZERO
	var camera_transform = camera.global_transform
	
	if Input.is_action_pressed("move_right"):
		direction += camera_transform.basis.x
	if Input.is_action_pressed("move_left"):
		direction -= camera_transform.basis.x
	if Input.is_action_pressed("move_back"):
		direction += camera_transform.basis.z
	if Input.is_action_pressed("move_forward"):
		direction -= camera_transform.basis.z
	
	if direction != Vector3.ZERO:
		direction = global_transform.basis * direction
		direction = direction.normalized()
	
	# Ground Velocity
	target_velocity.x = direction.x * speed
	target_velocity.z = direction.z * speed
	target_velocity.y = direction.y * speed 
	

	# Moving the Character
	velocity = target_velocity
	move_and_slide()
