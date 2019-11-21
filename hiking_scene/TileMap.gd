extends ParallaxLayer

var speed : float = 0
var direction_x : int = 0


func _on_Beatrix_moved_x(direction_x : int, speed : float) -> void:
	self.speed = speed
	self.direction_x = direction_x


func _process(delta: float) -> void:
	motion_offset.x -= self.speed * self.direction_x * delta
	motion_offset.x = min(0, motion_offset.x)
	speed = 0
	direction_x = 0