extends ProgressBar


func _on_Beatrix_terror_changed(terror : float) -> void:
	self.value += terror*15
	self.value = clamp(self.value, 0, 100)
