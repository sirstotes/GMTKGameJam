extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$Robot.connect("begin_editing", $Draggables, "show")
	$Robot.connect("finish_editing", $Draggables, "hide")
	for part in get_tree().get_nodes_in_group("Part"):
		$Robot.connect("begin_editing", part, "_set_paused", [true])
		$Robot.connect("finish_editing", part, "_set_paused", [false])


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
