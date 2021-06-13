extends Camera2D

export var followPath : NodePath

var follow : Node

func _ready() -> void:
	follow = get_node(followPath)
func _process(delta) -> void:
	#position = Vector2(max(min(follow.position.x, boundaryRight), boundaryLeft), max(min(follow.position.y, boundaryBottom), boundaryTop))
	position = follow.global_position
