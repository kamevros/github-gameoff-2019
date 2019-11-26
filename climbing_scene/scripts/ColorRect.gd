extends ColorRect


func _on_Gustaf_climbing_ended() -> void:
	self.modulate = Color(0,0,0,0)
	self.show()

	$ModulateTween.interpolate_property(self, "modulate", Color(0,0,0,0), Color(0,0,0,1), 3, Tween.TRANS_LINEAR, Tween.EASE_IN)
	$ModulateTween.start()
	
	yield($ModulateTween, "tween_completed")
	
	globals.string_to_render = "gustaf_end"
	scene_manager.change_scene(globals.menu_scene)
