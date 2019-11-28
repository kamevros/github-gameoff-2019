extends Sprite

onready var tween : Tween = $Tween


func _on_Gustaf_top_reached() -> void:
	show()
	
	tween.interpolate_property(self, "modulate", Color(0,0,0,0), Color(1,1,1,1), 2, Tween.TRANS_LINEAR, Tween.EASE_IN)
	tween.start()
	
