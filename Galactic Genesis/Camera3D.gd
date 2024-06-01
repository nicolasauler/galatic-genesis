extends Camera3D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
	#pass

func _input(event):
	#if event is InputEventMouseMotion and Input.is_action_pressed("mouse"):
		#rotate_object_local(Vector3.UP, event.relative.x * 0.001)
		#rotate_object_local(Vector3.RIGHT, event.relative.y * 0.001)
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_WHEEL_UP:
			fov += 1 #Camera
		elif event.button_index == MOUSE_BUTTON_WHEEL_DOWN:
			fov -= 1 #Camera
