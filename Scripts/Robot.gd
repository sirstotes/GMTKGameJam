extends RigidBody2D

signal begin_editing()
signal finish_editing()

export var draggableHolderPath : NodePath

var editing : bool = false
var draggableHolder : Node2D

const DRAGGABLE = preload("res://Parts/Draggable.tscn")
func _ready():
	if draggableHolderPath != "":
		draggableHolder = get_node(draggableHolderPath)
#	$Block/Attachments/Attachment2._attach($Controller/Attachments/Attachment)
#	$Thruster/Attachments/Attachment1._attach($Block/Attachments/Attachment4)
#	$Thruster2/Attachments/Attachment1._attach($Block/Attachments/Attachment1)
#	$Thruster3/Attachments/Attachment1._attach($Block/Attachments/Attachment3)
func _process(delta) -> void:
	if Input.is_action_just_pressed("ui_select"):
		if editing:
			editing = false
			sleeping = false
			emit_signal("finish_editing")
			$Controller/Attachments.hide()
			for attachment in $Controller/Attachments.get_children():
				if attachment.other != null:
					var part = attachment.other.get_parent().get_parent()
					_add_part(part)
					attachment.other._position()
					mass = 1
					_recursive_get_parts(attachment.other._get_siblings())
		else:
			editing = true
			sleeping = true
			emit_signal("begin_editing")
			for child in get_children():
				print(child.name)
				if child is Part:
					child.get_node("Attachments").show()
					if child.name != "Controller":
						var newDraggable = DRAGGABLE.instance()
						newDraggable.global_position = child.global_position
						draggableHolder.add_child(newDraggable)
						remove_child(child)
						newDraggable.add_child(child)
						child.onRobot = false
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
