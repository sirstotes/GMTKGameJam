extends Node
var mouseIsDragging : bool = false
func _process(delta):
	if !Input.is_mouse_button_pressed(BUTTON_LEFT):
		mouseIsDragging = false
