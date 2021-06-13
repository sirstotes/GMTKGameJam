extends StaticBody2D

signal player_entered

var active : bool = true

func _set_active(a : bool):
	active = a
	$Area2D.visible = a

func _on_body_entered(body : Node) -> void:
	if body.is_in_group("Robot"):
		if active and body.health > 0:
			emit_signal("player_entered")
