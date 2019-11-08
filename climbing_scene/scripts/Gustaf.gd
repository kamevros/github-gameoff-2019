extends KinematicBody2D
class_name PlayerGoat

onready var sprite : AnimatedSprite = $AnimatedSprite

export(int, 0, 1000, 1) var walk_speed : int = 100
export(int, 0, 1000, 1) var jump_speed : int = 300

export(float, 0, 1, 0.1) var base_acceleration : float = 1
export(float, 0, 1, 0.1) var base_friction : float = 1

export(float, 0, 1, 0.05) var slippery_acceleration : float = 0.05
export(float, 0, 1, 0.05) var slippery_friction : float = 0.2

export var current_state : int = PLAYER_STATE.FALLING

onready var acceleration : float = base_acceleration
onready var friction : float = base_friction

enum PLAYER_STATE { IDLE, JUMPING, FALLING }

const GRAVITY_SPEED : int = 1300

var direction : = Vector2()
var velocity : = Vector2()
var can_jump : bool = false
var anim : String = "idle"


func _ready() -> void:
	sprite.play(anim)


func _process(delta : float) -> void:
	var new_anim : String = "idle"
	
	direction = get_input()

	if direction.x != 0:
		velocity.x = lerp(velocity.x, direction.x * walk_speed, acceleration)
		new_anim = "walk"
	else:
		velocity.x = lerp(velocity.x, 0, friction)
		
	
	position.x = clamp(position.x, 
		$Camera.limit_left,
		$Camera.limit_right)

	match current_state:
		PLAYER_STATE.JUMPING:
			velocity.y = -jump_speed
			current_state = PLAYER_STATE.FALLING
			can_jump = false
			new_anim = "jump"
		PLAYER_STATE.FALLING:
			velocity.y += GRAVITY_SPEED * delta
			if is_on_floor():
				can_jump = true
				current_state = PLAYER_STATE.IDLE
				velocity.y = 0
		PLAYER_STATE.IDLE:
			velocity.y += GRAVITY_SPEED * delta
			if !is_on_floor() :
				current_state = PLAYER_STATE.FALLING
				
	if anim != new_anim:
		sprite.play(new_anim)
		
		if sprite.animation == "jump":
			yield( sprite, "animation_finished" )
			anim = new_anim
		else:
			anim = new_anim


func _physics_process(delta : float) -> void:
	velocity = move_and_slide(velocity, Vector2.UP)


func get_input() -> Vector2:
	var direction : = Vector2()

	if Input.is_action_pressed("movement_right"):
		direction.x = +1
		sprite.flip_h = false
	elif Input.is_action_pressed("movement_left"):
		direction.x = -1
		sprite.flip_h = true

	if can_jump && Input.is_action_just_pressed("movement_up"):
		direction.y = -1
		current_state = PLAYER_STATE.JUMPING

	return direction
	
	
func slip(is_slippery : bool) -> void:
	if is_slippery:
		acceleration = slippery_acceleration
		friction = slippery_friction
	else:
		acceleration = base_acceleration
		friction = base_friction
	


