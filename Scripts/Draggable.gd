extends Area2D

signal drag()
signal drop()

var mouseOver : bool = false
var dragging : bool = false
var mouseOffset : Vector2 = Vector2(0, 0)
var paused : bool = true

func _get_part() -> Node:
	for child in get_children():
		if child is Part:
			return child
	return null

func _ready() -> void:
	$Area.connect("mouse_entered", self, "_set_mouse_over", [true])
	$Area.connect("mouse_exited", self, "_set_mouse_over", [false])
	connect("drag", self, "_on_drag")
	connect("drop", self, "_on_drop")
func _process(delta) -> void:
	if _get_part() == null:
		queue_free()
	if paused:
		$Area/Polygon2D.visible = mouseOver
		$Area.position = _get_part().position
		if dragging:
			if !Input.is_mouse_button_pressed(BUTTON_LEFT):
				emit_signal("drop")
			position = get_viewport().get_mouse_position() + mouseOffset
		elif Input.is_mouse_button_pressed(BUTTON_LEFT):
			if mouseOver and !GlobalVars.mouseIsDragging:
				emit_signal("drag")
		if Input.is_action_just_pressed("rotate_left") and mouseOver:
			var part = _get_part()
			for attachment in _get_part().get_node("Attachments").get_children():
				attachment._detach()
			part._set_direction(part.direction+1)
		if Input.is_action_just_pressed("rotate_right") and mouseOver:
			var part = _get_part()
			for attachment in part.get_node("Attachments").get_children():
				attachment._detach()
			part._set_direction(part.direction-1)
	else:
		dragging = false
func _on_drag() -> void:
	GlobalVars.mouseIsDragging = true
	mouseOffset = position - get_viewport().get_mouse_position()
	dragging = true
	for attachment in _get_part().get_node("Attachments").get_children():
		attachment._detach()
func _on_drop() -> void:
	dragging = false
	for attachment in _get_part().get_node("Attachments").get_children():
		if len(attachment.touching) > 0:
			for t in attachment.touching:
				if t is Attachment:
					attachment._attach(attachment.touching[0])
					break
					break
func _set_mouse_over(o: bool) -> void:
	mouseOver = o
