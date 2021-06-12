extends Area2D
var paused : bool = true
var showButton : bool = false
func _ready() -> void:
	$Button.hide()
	$Button.connect("pressed", get_parent(), "_begin_editing", [self])
func _process(delta):
	if paused:
		$Button.visible = false
	else:
		$Button.visible = showButton
func _on_body_entered(body) -> void:
	if body.is_in_group("Robot"):
		showButton = true
func _on_body_exited(body) -> void:
	if body.is_in_group("Robot"):
		showButton = false
