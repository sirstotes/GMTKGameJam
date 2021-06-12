extends KinematicBody2D
class_name Bullet

export var direction : Vector2 = Vector2(1, 0)
export var speed : float = 64
export var lifeTime : float = 10
export var damage = 1

var timeAlive = 0
var velocity = Vector2(0, 0)

func _ready():
	timeAlive = 0
	rotation = direction.angle()
func _process(delta):
	timeAlive += delta
	if timeAlive > lifeTime:
		queue_free()
	rotation = direction.angle()
	var col = move_and_collide((velocity + direction*speed)*delta)
