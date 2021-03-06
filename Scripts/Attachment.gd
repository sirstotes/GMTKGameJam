extends Area2D
class_name Attachment

export var side : int = 0

var other
var touching = []

func _position() -> void:
	var parent : Part = get_parent().get_parent()
	#if side == (other.side + 2)%4:
	#	parent._set_direction(0)
	#if side == (other.side + 1)%4:
	#	parent._set_direction(1)
	#if side == (other.side + 0)%4:
	#	parent._set_direction(2)
	#if side == (other.side + 3)%4:
	#	parent._set_direction(3)
	parent.position = parent.position + (other.global_position - global_position)
func _attach(o) -> void:
	if !o._is_attached():
		if (side + get_parent().get_parent().direction)%4 == (o.side + 2 + o.get_parent().get_parent().direction)%4:
			other = o
			o.other = self
			_position()
			hide()
			other.hide()
func _detach() -> void:
	if other != null:
		show()
		other.show()
		other.other = null
		other = null
func _is_attached() -> bool:
	return other != null
func _get_siblings() -> Array:
	var others = []
	for child in get_parent().get_children():
		if child != self:
			others.append(child)
	return others
func _ready():
	$Sprite.rotation = -(PI/2)*side
func _on_area_entered(area):
	touching.append(area)
func _on_area_exited(area):
	touching.erase(area)
