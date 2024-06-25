extends Node3D  # Make sure you extend the appropriate class

@export var rotation_speed2: float = 2
@export var rotation_speed1: float = 1
@export var rotation_speed0: float = .5

func _physics_process(delta: float) -> void:
	# Calculate the rotation amount for this frame
	var rotation_amount0 = deg_to_rad(rotation_speed0 * delta)
	
	var child0 = get_child(0)
	if child0 is Node3D:
		var child_node0 = child0 as Node3D
		child_node0.global_transform = Transform3D(Basis(Vector3.UP, rotation_amount0), Vector3.ZERO) * child_node0.global_transform
		
	var rotation_amount1 = deg_to_rad(rotation_speed1 * delta)
	var child1 = get_child(1)
	if child1 is Node3D:
		var child_node1 = child1 as Node3D
		child_node1.global_transform = Transform3D(Basis(Vector3.UP, rotation_amount1), Vector3.ZERO) * child_node1.global_transform
	
	var rotation_amount2 = deg_to_rad(rotation_speed2 * delta)
	var child2 = $planet_red
	var child_node2 = child2 as Node3D
	child_node2.global_transform  = Transform3D(Basis(Vector3.UP, rotation_amount2), Vector3.ZERO) * child_node2.global_transform
	
	# Rotate each child around the parent node (self)
	#for child in get_children():
	#	print(child)
	#	if child is Node3D:
	#		var child_node = child as Node3D
	#		# Calculate the new global transform after rotation
	#		child_node.global_transform = Transform3D(Basis(Vector3.UP, rotation_amount), Vector3.ZERO) * child_node.global_transform
