extends Part
class_name Jumper

export var power : float = 50

func _grounded() -> bool:
	for body in $GroundCheck.get_overlapping_bodies():
		if body.is_in_group("Ground"):
			return true
	return false
	return false

func _physics_process(delta) -> void:
	if !paused and onRobot:
		if Input.is_action_pressed(_get_local_up()):
			$Small.hide()
			$Big.show()
			if _grounded():
				get_parent().apply_central_impulse(Vector2.RIGHT.rotated(global_rotation)*power)
		else:
			$Small.show()
			$Big.hide()
