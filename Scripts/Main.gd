extends Node2D

func _ready():
	_begin_editing($Builder)
func _begin_editing(builder : Node2D):
	#$Draggables.show()
	$CanvasLayer/Editor/Button.show()
	for draggable in get_tree().get_nodes_in_group("Draggable"):
		draggable.paused = true
	for part in get_tree().get_nodes_in_group("Part"):
		part.paused = true
	for enemy in get_tree().get_nodes_in_group("Enemy"):
		enemy.paused = true
	for builder in get_tree().get_nodes_in_group("Builder"):
		builder.paused = true
	$Robot._begin_editing(builder.get_node("RobotSpace").global_position)
func _finish_editing():
	#$Draggables.hide()
	$CanvasLayer/Editor/Button.hide()
	for draggable in get_tree().get_nodes_in_group("Draggable"):
		draggable.paused = false
	for part in get_tree().get_nodes_in_group("Part"):
		part.paused = false
	for enemy in get_tree().get_nodes_in_group("Enemy"):
		enemy.paused = false
	for builder in get_tree().get_nodes_in_group("Builder"):
		builder.paused = false
	$Robot._finish_editing()
func _input(event):
	if event.is_action_pressed("pause"):
		get_tree().paused = true
		$CanvasLayer/Pause.show()
func _unpause():
	get_tree().paused = false
	$CanvasLayer/Pause.hide()
func _reset():
	get_tree().paused = false
	get_tree().reload_current_scene()
func _next_level():
	pass
func _menu():
	pass
func _on_goal_entered(body):
	if body.is_in_group("Robot"):
		_next_level()
func _update_player_ui():
	$CanvasLayer/UI/ColorRect.rect_scale.x = float($Robot.health)/float($Robot.maxHealth)
