extends Node2D
var oldScene
var newScenePath
var outTransition
var inTransition
func _ready():
	oldScene = $Scenes.get_children()[0]
	connect_scene()
	$Transition.play("FadeOut")
func change_scene(scene):
	change_scene_with_transition(scene, "FadeIn", "FadeOut")
func change_scene_with_transition(scene, transitionOut, transitionIn):
	newScenePath = load(scene)
	outTransition = transitionOut
	inTransition = transitionIn
	$Transition.play(transitionOut)
	$Transition.connect("animation_finished", self, "on_transition_end")
func on_transition_end(anim):
	$Transition.disconnect("animation_finished", self, "on_transition_end")
	var newScene = newScenePath.instance()
	$Scenes.remove_child(oldScene)
	$Scenes.add_child(newScene)
	oldScene.queue_free()
	oldScene = newScene
	connect_scene()
	$Transition.play(inTransition)
func connect_scene():
	oldScene.connect("change_scene", self, "change_scene")
	oldScene.connect("change_scene_with_transition", self, "change_scene_with_transition")
