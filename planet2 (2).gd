extends Node3D

var targeted = false:
	set(val):
		targeted = set_targeted(val)
	get:
		return targeted

@onready var shader = $MeshInstance3D.mesh.material.next_pass

@onready var description = $description/MeshInstanceDescription
# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func _on_area_3d_input_event(camera, event, position, normal, shape_idx):
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		_toggle_mesh_visibility()

func set_targeted(val):
	targeted = val
	if targeted:
		shader.set_shader_param("strength", 0.2)
	else:
		shader.set_shader_param("strength", 0.0)
		
func _toggle_mesh_visibility():
	var target_mesh_instance = $"../description/MeshInstanceDescription"
	if target_mesh_instance:
		target_mesh_instance.visible = not target_mesh_instance.visible


func _on_area_3d_mouse_entered():
	var contour = $MeshInstance3D/MeshInstance3D
	contour.visible = true


func _on_area_3d_mouse_exited():
	var contour = $MeshInstance3D/MeshInstance3D
	contour.visible = false # Replace with function body.
