extends Part
class_name Roller
export var power : float = 3

func _grounded() -> bool:
	var space_state = get_world_2d().direct_space_state
	var result = space_state.intersect_ray($RayCastStart1.global_position, $RayCastEnd1.global_position)
	if result:
		return result.collider.is_in_group("Ground")
	result = space_state.intersect_ray($RayCastStart2.global_position, $RayCastEnd2.global_position)
	if result:
		return result.collider.is_in_group("Ground")
	return false
	result = space_state.intersect_ray($RayCastStart3.global_position, $RayCastEnd3.global_position)
	if result:
		return result.collider.is_in_group("Ground")
	return false
func _physics_process(delta) -> void:
	if !paused and onRobot:
		if Input.is_action_pressed(_get_local_right()):
			$Sprite.play("forward")
			if _grounded():
				get_parent().apply_central_impulse(Vector2.DOWN.rotated(rotation)*power)
		elif Input.is_action_pressed(_get_local_left()):
			$Sprite.play("forward", true)
			if _grounded():
				get_parent().apply_central_impulse(Vector2.DOWN.rotated(-rotation)*power)
		else:
			$Sprite.playing = false
