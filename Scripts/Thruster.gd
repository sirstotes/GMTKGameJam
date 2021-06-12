extends Part
class_name Thruster

export var power : float = 10
export var sustain : float = 5
export var recharge : float = 1

var time_activated : float = 0
var time_deactivated : float = 0
var charged : float = true

func _physics_process(delta) -> void:
	if !paused and onRobot:
		if Input.is_action_pressed(_get_local_up()):
			time_activated += delta
			time_deactivated = 0
			if time_activated > sustain:
				charged = false
			if charged:
				get_parent().apply_central_impulse(Vector2.RIGHT.rotated(rotation)*power)
		else:
			time_activated = 0
			time_deactivated += delta
			if time_deactivated > recharge:
				charged = true
