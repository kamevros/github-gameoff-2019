extends ParallaxBackground

func _process(delta : float) -> void:
	$ParallaxLayer.position.y -= 50

