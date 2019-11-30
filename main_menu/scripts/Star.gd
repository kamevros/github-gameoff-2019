extends Node2D

var rng = RandomNumberGenerator.new()

func _ready() -> void:
	rng.randomize()
	var my_random_number = rng.randf_range(0, 1)
	$AnimationPlayer.play("blinking", my_random_number, my_random_number)

