extends Camera2D

export var followPath : NodePath
export var boundaryLeft : float = 256
export var boundaryRight : float = 256
export var boundaryTop : float = 64
export var boundaryBottom : float = 64

var follow : Node

func _ready() -> void:
	follow = get_node(followPath)
func _process(delta) -> void:
	position = Vector2(max(min(follow.position.x, boundaryRight), boundaryLeft), max(min(follow.position.y, boundaryBottom), boundaryTop))
	#position = position.linear_interpolate(follow.position, delta)
