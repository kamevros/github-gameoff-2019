extends Node2D

onready var animated_sprite : AnimatedSprite = $AnimatedSprite

var spawned = false

func _ready() -> void:
	animated_sprite.play("idle")
	hide()


func _process(delta: float) -> void:
	if spawned:
		position.x += delta * 100



func _on_Beatrix_spawn_timer_ended(position : Vector2) -> void:
	if !spawned:
		spawned = true
		show()
		self.position = position
		self.position.x = position.x - 480
