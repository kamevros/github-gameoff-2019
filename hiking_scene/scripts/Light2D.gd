extends Light2D

func _on_Beatrix_terror_changed(terror : float) -> void:
	if terror == 0:
		self.energy = 1
	elif terror > 0:
		self.energy = 1-terror/100
