extends RayCast3D

var looking_at = null

func _process(delta):
	var coll = get_collider()
	
	if coll != looking_at:
		if coll != null and "targeted" in coll:
			coll.targeted = true
		if looking_at != null and "targeted" in looking_at:
			looking_at.targeted = false
		looking_at = coll
