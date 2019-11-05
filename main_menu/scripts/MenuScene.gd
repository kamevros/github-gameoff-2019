extends Node

var next_scene = "res://climbing_scene/scenes/ClimbingScene.tscn"


func _process(delta : float) -> void:
	if Input.is_action_pressed("ui_accept"):
		get_tree().change_scene(next_scene)
