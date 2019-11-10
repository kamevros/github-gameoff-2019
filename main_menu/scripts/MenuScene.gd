extends Node

var next_scene = "res://climbing_scene/scenes/ClimbingScene.tscn"


func _process(delta : float) -> void:
	if Input.is_action_pressed("ui_accept"):
		scene_manager.change_scene(next_scene)
