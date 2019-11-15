extends ColorRect


func _on_Remy_scene_timer_ended(victory : bool) -> void:
	self.modulate = Color(0,0,0,0)
	self.show()

	$ModulateTween.interpolate_property(self, "modulate", Color(0,0,0,0), Color(0,0,0,1), 3, Tween.TRANS_LINEAR, Tween.EASE_IN)
	$ModulateTween.start()
	
	yield($ModulateTween, "tween_completed")
	
	if victory:
		scene_manager.change_scene(globals.menu_scene)
	else:
		scene_manager.change_scene(globals.game_over_scene)

