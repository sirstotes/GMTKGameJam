extends Node2D

export var speed : float = 50
export var wobble : float = 32
export var height: float = 96

var dir : Vector2 = Vector2(-1, 0)
var distToGround : float = 0
var timeAwake : float = 0

func _physics_process(delta):
	timeAwake += delta
	if !get_parent().paused:
		dir.y = (distToGround-height + sin(timeAwake) * wobble) * 0.03
		get_parent().move_and_collide(dir*speed*delta)
		var space_state = get_world_2d().direct_space_state
		var result = space_state.intersect_ray($RayStart.global_position, $RayEnd.global_position)
		if result:
			if dir.x >= 1:
				dir.x = -1
			else:
				dir.x = 1
			$RayStart.position.x = -$RayStart.position.x
			$RayEnd.position.x = -$RayEnd.position.x
		result = space_state.intersect_ray($GroundRayStart.global_position, $GroundRayEnd.global_position)
		if result:
			if result.collider.is_in_group("Robot"):
				distToGround = 256
				dir.x = 0
			else:
				distToGround = abs(global_position.y - result.position.y)
		else:
			distToGround = 128
