extends Area2D

signal drag()
signal drop()

var dragging : bool = false
var mouseOffset : Vector2 = Vector2(0, 0)
var paused : bool = true

func _ready() -> void:
	connect("drag", self, "_on_drag")
	connect("drop", self, "_on_drop")
func _process(delta) -> void:
	if get_child_count() <= 0:
		queue_free()
	if paused:
		if dragging:
			position = get_viewport().get_mouse_position() + mouseOffset
			if Input.is_action_just_pressed("rotate_left"):
				get_child(0)._set_direction(get_child(0).direction+1)
				emit_signal("drop")
			if Input.is_action_just_pressed("rotate_right"):
				get_child(0)._set_direction(get_child(0).direction-1)
				emit_signal("drop")
	else:
		dragging = false
func _on_drag() -> void:
	dragging = true
	for attachment in get_child(0).get_node("Attachments").get_children():
		attachment._detach()
func _on_drop() -> void:
	dragging = false
	for attachment in get_child(0).get_node("Attachments").get_children():
		if len(attachment.touching) > 0:
			for t in attachment.touching:
				if t is Attachment:
					attachment._attach(attachment.touching[0])
					break
					break
func _on_input_event(viewport, event, shape_idx) -> void:
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT and event.pressed:
			emit_signal("drag")
			mouseOffset = position - get_viewport().get_mouse_position()
		elif event.button_index == BUTTON_LEFT and !event.pressed:
			emit_signal("drop")
