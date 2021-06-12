extends Part
class_name Jumper

export var power : float = 200

func _grounded() -> bool:
	var space_state = get_world_2d().direct_space_state
	var result = space_state.intersect_ray($RayCastStart1.global_position, $RayCastEnd1.global_position)
	if result:
		return result.collider.is_in_group("Ground")
	result = space_state.intersect_ray($RayCastStart2.global_position, $RayCastEnd2.global_position)
	if result:
		return result.collider.is_in_group("Ground")
	return false

func _physics_process(delta) -> void:
	if !paused and onRobot:
		if Input.is_action_pressed(_get_local_up()):
			shape.extents = shape.extents.linear_interpolate(Vector2(17, 16), delta*10)
			$Small.hide()
			$Big.show()
			if _grounded():
				get_parent().apply_central_impulse(Vector2.RIGHT.rotated(rotation)*power)
		else:
			shape.extents = shape.extents.linear_interpolate(Vector2(11, 16), delta*10)
			$Small.show()
			$Big.hide()
