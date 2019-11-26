extends Node2D

onready var animated_sprite : AnimatedSprite = $AnimatedSprite
onready var collision : Area2D = $Area2D/CollisionShape2D

export(float, 50, 300) var speed : float = 150

var spawned = false

onready var initial_position : Vector2 = self.position

func _ready() -> void:
	animated_sprite.play("idle")
	collision.disabled = true
	hide()


func _process(delta: float) -> void:
	if spawned:
		position.x += delta * speed


func _on_Beatrix_spawn_timer_ended(position : Vector2) -> void:
	if !spawned:
		spawned = true
		collision.disabled = false
		show()
		self.position = position
		self.position.x = position.x - 480


func _on_VisibilityNotifier2D_viewport_exited(viewport: Viewport) -> void:
	spawned = false
	hide()
	self.position = initial_position
	self.position.x = position.x - 480
	collision.disabled = true
