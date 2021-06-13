extends Part
class_name Thruster

export var power : float = 10

var time_activated : float = 0
var time_deactivated : float = 0

func _physics_process(delta) -> void:
	if !paused and onRobot:
		if Input.is_action_pressed(_get_local_up()):
			time_activated += delta
			time_deactivated = 0
			$AnimatedSprite.show()
			get_parent().apply_central_impulse(Vector2.RIGHT.rotated(global_rotation)*power)
		else:
			$AnimatedSprite.hide()
			time_activated = 0
			time_deactivated += delta
