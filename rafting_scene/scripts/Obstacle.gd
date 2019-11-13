extends Node2D
class_name obstacle


func _process(delta: float) -> void:
	position.y += globals.rafting_speed * delta
	
	
func _on_ClearTimer_timeout() -> void:
	queue_free()
