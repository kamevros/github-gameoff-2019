extends Node2D

func _ready() -> void:
	yield(get_tree().create_timer(2.0), "timeout")
	scene_manager.change_scene(globals.menu_scene)

