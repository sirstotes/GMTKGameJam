extends Part
class_name Gun

export var recharge : float = 1

var charge : float = 0
var bulletHolder : Node

const BULLET : PackedScene = preload("res://Spawn/Bullet.tscn")

func _process(delta) -> void:
	if !paused and onRobot:
		charge += delta
		if Input.is_action_just_pressed("shoot"):
			if charge > recharge:
				charge = 0
				var bullet = BULLET.instance()
				bullet.position = $Spawn.global_position
				bullet.direction = ($Spawn.global_position-global_position).normalized()
				bullet.velocity = get_parent().linear_velocity
				bulletHolder.add_child(bullet)
