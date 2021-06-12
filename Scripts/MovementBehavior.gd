extends Node2D

export var speed : float = 5120

var dir : Vector2 = Vector2(-1, 0)
var gravity : Vector2 = Vector2(0, 4000)

func _physics_process(delta):
	if !get_parent().paused:
		get_parent().move_and_slide((dir*speed + gravity)*delta, Vector2.UP)
		var space_state = get_world_2d().direct_space_state
		var result = space_state.intersect_ray($RayStart.global_position, $RayEnd.global_position)
		if result:
			if !result.collider.is_in_group("Robot"):
				dir.x = -dir.x
				$RayStart.position.x = -$RayStart.position.x
				$RayEnd.position.x = -$RayEnd.position.x
