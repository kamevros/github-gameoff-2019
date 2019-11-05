extends KinematicBody2D

var speed : float = 200
const GRAVITY : float = 200.0
var velocity : = Vector2()


func _physics_process(delta : float) -> void:
	is_on_ground()
	
	get_input()
	
	velocity.y += GRAVITY
	
	move_and_collide(velocity * delta)

func is_on_ground() -> bool:
	return true
	

func get_input() -> void:
	velocity = Vector2()
	
	if Input.is_action_pressed("movement_right"):
		velocity.x += speed
		$Sprite.flip_h = false
	elif Input.is_action_pressed("movement_left"):
		velocity.x -= speed
		$Sprite.flip_h = true
		
	if Input.is_action_pressed("movement_up"):
		velocity.y -= GRAVITY * 1.5