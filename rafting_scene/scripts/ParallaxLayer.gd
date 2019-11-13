extends ParallaxLayer

func _process(delta: float) -> void:
	motion_offset.y += globals.rafting_speed * delta

