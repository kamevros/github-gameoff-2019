extends KinematicBody2D

onready var sprite : AnimatedSprite = $AnimatedSprite as AnimatedSprite
onready var camera = get_node("../Camera2D")

var direction : = Vector2()
var velocity : = Vector2()

func _ready() -> void:
	sprite.play("idle")


func _process(delta : float) -> void:
	camera.position.y = position.y - 50
	direction = get_input()


func _physics_process(delta : float) -> void:
	velocity.y = -100
	velocity = move_and_slide(velocity)


func get_input() -> Vector2:
	var direction : = Vector2()

	if Input.is_action_pressed("movement_right"):
		direction.x = +1
		sprite.flip_h = false
	elif Input.is_action_pressed("movement_left"):
		direction.x = -1
		sprite.flip_h = true
			
	return direction
