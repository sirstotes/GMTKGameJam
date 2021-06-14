extends Part
class_name Roller
export var power : float = 3

func _grounded() -> bool:
	for body in $GroundCheck.get_overlapping_bodies():
		if body.is_in_group("Ground"):
			return true
	return false
func _physics_process(delta) -> void:
	if !paused and onRobot:
		if Input.is_action_pressed(_get_local_right()):
			$Sprite.play("forward")
			if _grounded():
				get_parent().apply_central_impulse(Vector2.DOWN.rotated(global_rotation)*power)
		elif Input.is_action_pressed(_get_local_left()):
			$Sprite.play("forward", true)
			if _grounded():
				get_parent().apply_central_impulse(Vector2.DOWN.rotated(-global_rotation)*power)
		else:
			$Sprite.playing = false
