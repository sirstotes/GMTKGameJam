extends KinematicBody2D
class_name Enemy

export var health : int = 1
export var damage : int  = 1

var paused : bool = true

func _process(delta):
	if health <= 0:
		queue_free()

func _on_body_entered(body):
	if !paused:
		if body.is_in_group("Bullet"):
			health -= body.damage
			body.queue_free()
		if body.is_in_group("Robot"):
			body._damage(damage)
			health -= 1
