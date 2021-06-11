extends CollisionShape2D
class_name Part
export var direction : int = 0
export var onRobot : bool = true
var mass = 1

func _set_direction(dir : int):
	direction = dir%4
	rotation = -(PI/2)*direction
func _is_direction_pressed() -> bool:
	if direction == 0:
		return Input.is_action_pressed("right")
	elif direction == 1:
		return Input.is_action_pressed("up")
	elif direction == 2:
		return Input.is_action_pressed("left")
	elif direction == 3:
		return Input.is_action_pressed("down")
	return false
func _get_local_right() -> String:
	if direction == 0:
		return "up"
	elif direction == 1:
		return "right"
	elif direction == 2:
		return "down"
	else:
		return "left"
func _get_local_left() -> String:
	if direction == 0:
		return "down"
	elif direction == 1:
		return "left"
	elif direction == 2:
		return "up"
	else:
		return "right"
func _get_local_down() -> String:
	if direction == 0:
		return "left"
	elif direction == 1:
		return "down"
	elif direction == 2:
		return "right"
	else:
		return "up"
func _get_local_up() -> String:
	if direction == 0:
		return "right"
	elif direction == 1:
		return "up"
	elif direction == 2:
		return "left"
	else:
		return "down"
