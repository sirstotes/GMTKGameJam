extends Camera2D

export var followPath : NodePath
export var boundaryLeft : float = 0
export var boundaryRight : float = 256
export var boundaryTop : float = 0
export var boundaryBottom : float = 144

var follow : Node

func _ready() -> void:
	follow = get_node(followPath)
func _process(delta) -> void:
	position = Vector2(max(min(follow.position.x, boundaryRight), boundaryLeft), max(min(follow.position.y, boundaryBottom), boundaryTop))
	#position = position.linear_interpolate(follow.position, delta)
