extends RigidBody2D
class_name Robot

signal begin_editing()
signal finish_editing()

export var draggableHolderPath : NodePath
export var maxHealth = 3
export var health = 3

var draggableHolder : Node2D

const DRAGGABLE = preload("res://Parts/Draggable.tscn")
func _ready():
	if draggableHolderPath != "":
		draggableHolder = get_node(draggableHolderPath)
func _finish_editing():
	mode = RigidBody2D.MODE_RIGID
	_build()
func _begin_editing(pos):
	mode = RigidBody2D.MODE_KINEMATIC
	position = pos
	rotation = 0
	
	for child in get_children():
		print(child.name)
		if child is Part:
			child.get_node("Attachments").show()
			if child.name != "Controller":
				var newDraggable = DRAGGABLE.instance()
				newDraggable.position = pos+child.position
				child.position = Vector2(0, 0)
				draggableHolder.add_child(newDraggable)
				remove_child(child)
				newDraggable.add_child(child)
				child.onRobot = false
#func _integrate_forces(state):
#	if editing:
#		set_sleeping(true)
#		state.transform.origin = pausePosition
#		var xform = state.get_transform().rotated(-rotation)
#		state.set_transform(xform)
func _build() -> void:
	$Controller/Attachments.hide()
	for attachment in $Controller/Attachments.get_children():
		if attachment.other != null:
			var part = attachment.other.get_parent().get_parent()
			_add_part(part)
			attachment.other._position()
			mass = 1
			_recursive_get_parts(attachment.other._get_siblings())
func _recursive_get_parts(siblings) -> void:
	if len(siblings) > 0:
		for s in siblings:
			if s.other != null:
				var part = s.other.get_parent().get_parent()
				mass += part.mass
				_add_part(part)
				s.other._position()
				_recursive_get_parts(s.other._get_siblings())
func _add_part(p : Part) -> void:
	p.onRobot = true
	p.get_node("Attachments").hide()
	p.get_parent().remove_child(p)
	add_child(p)
	p.paused = false
	if p is Gun:
		p.bulletHolder = get_parent().get_node("Bullets")
func _damage(amount : int):
	health -= amount
	get_parent()._update_player_ui()
	if health <= 0:
		get_parent()._reset()
