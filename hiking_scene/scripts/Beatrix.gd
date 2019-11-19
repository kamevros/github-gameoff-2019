extends KinematicBody2D
class_name PlayerRabbit

export(int, 50, 500) var speed : int = 100

onready var sprite : AnimatedSprite = $AnimatedSprite

var direction : = Vector2()
var velocity : = Vector2()

var moving : bool = false
var terror : float = 0

signal terror_changed

func _process(delta: float) -> void:
	var direction : Vector2 = get_input()
	move_and_collide(direction * delta * speed)
	manage_terror(delta)
	
	
func get_input() -> Vector2:
	var direction : = Vector2()
	
	moving = false
	
	if Input.is_action_pressed("movement_right"):
		moving = true
		direction.x = +1
		sprite.flip_h = false
	
	if Input.is_action_pressed("movement_left"):
		moving = true
		direction.x = -1
		sprite.flip_h = true
		
	if Input.is_action_pressed("movement_up"):
		moving = true
		direction.y = -1
			
	if Input.is_action_pressed("movement_down"):
		moving = true
		direction.y = +1
	
	return direction
	
	
func manage_terror(delta : float) -> void:
	terror = 0
	if moving:
		terror += delta
	else:
		terror -= delta*5
		
	emit_signal("terror_changed", terror)
		
		
	
func clamp_position() -> void:
	position.x = clamp(position.x, 24, 480-24)
	position.y = clamp(position.y, 240-48, 480-48)

