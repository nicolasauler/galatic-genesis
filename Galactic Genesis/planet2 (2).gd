extends Node3D

var targeted = false:
	set (val):
		targeted = set_targeted(val)
	get:
		return targeted

@onready var shader = $MeshInstance3D.mesh.material.next_pass
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _on_area_3d_input_event(camera, event, position, normal, shape_idx):
	if Input.is_action_pressed("mouse_left"):
			$description.visible = !$description.visible # Replace with function body.

func set_targeted(val):
	targeted = val
	if targeted:
		shader.set_shader_param("strength", 1.0)
	else:
		shader.set_shader_param("strength", 0.0)
