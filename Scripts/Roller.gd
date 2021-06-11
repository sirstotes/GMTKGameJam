extends Part
class_name Roller
export var power : float = 3
var grounded : bool = false

func _physics_process(delta) -> void:
	if onRobot:
		rotation = -(PI/2)*direction
		if grounded:
			if Input.is_action_pressed(_get_local_right()):
				get_parent().apply_central_impulse(Vector2.DOWN.rotated(rotation)*power)
			if Input.is_action_pressed(_get_local_left()):
				get_parent().apply_central_impulse(Vector2.DOWN.rotated(-rotation)*power)

func _on_GroundCheck_body_entered(body):
	grounded = true
func _on_GroundCheck_body_exited(body):
	grounded = false
