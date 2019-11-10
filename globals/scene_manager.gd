extends Node

# for debug only
func _ready():
	print("[Screen Metrics]")
	print("Display size: ", OS.get_screen_size())
	print("Decorated Window size: ", OS.get_real_window_size())
	print("Window size: ", OS.get_window_size())
	print("Project Settings: Width=", ProjectSettings.get_setting("display/window/size/width"), " Height=", ProjectSettings.get_setting("display/window/size/height"))
	print(OS.get_window_size().x)
	print(OS.get_window_size().y)

func change_scene(next_scene : String) -> void:
	get_tree().change_scene(next_scene)

