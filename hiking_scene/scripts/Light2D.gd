extends Light2D

var time : float = 0

func _process(delta: float) -> void:
	time += delta
	energy = sin((time * PI)*0.25)
