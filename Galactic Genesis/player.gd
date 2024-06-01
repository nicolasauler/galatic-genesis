extends CharacterBody3D

# How fast the player moves in meters per second.
@export var speed = 80
# The downward acceleration when in the air, in meters per second squared.
#@export var fall_acceleration = 10

var target_velocity = Vector3.ZERO

func _ready():
	pass

func _process(delta):
	_physics_process(delta)
	
func _physics_process(delta):
	var direction = Vector3.ZERO
		
	if Input.is_action_pressed("move_right"):
		direction.x -= 2
	if Input.is_action_pressed("move_left"):
		direction.x += 2
	if Input.is_action_pressed("move_back"):
		direction.z -= 2
	if Input.is_action_pressed("move_forward"):
		direction.z += 2

	if direction != Vector3.ZERO:
		direction = global_transform.basis * direction
		direction = direction.normalized()
		$Pivot.basis = Basis.looking_at(direction)
		
	# Ground Velocity
	target_velocity.x = direction.x * speed
	target_velocity.z = direction.z * speed
	#target_velocity.y = direction.y * speed - (fall_acceleration * delta)
	
	# Vertical Velocity
	#if not is_on_floor(): # If in the air, fall towards the floor. Literally gravity
		#target_velocity.y = target_velocity.y 

	# Moving the Character
	velocity = target_velocity
	move_and_slide()
	
func _input(event):
	if event is InputEventMouseMotion and Input.is_action_pressed("mouse"):
		rotate_y(-event.relative.x * 0.001)
		rotate_x(-event.relative.y * 0.001)
		$Pivot.rotate_x(-event.relative.y * 0.001)
		$Pivot.rotate_y(-event.relative.x * 0.001)
		
