extends KinematicBody2D
class_name PlayerRabbit

export(int, 50, 500) var speed : int = 100

onready var normal_speed : int = speed
onready var scared_speed : int = speed / 2
onready var ultra_scared_speed : int = speed / 3
onready var sprite : AnimatedSprite = $AnimatedSprite
onready var spawn_timer : Timer = $Timer

var anim : String = "idle"

var direction : = Vector2()
var velocity : = Vector2()

var moving : bool = false
var terror : float = 0
var spawn_timer_started = false

signal terror_changed
signal spawn_timer_ended

func _process(delta: float) -> void:
	var direction : Vector2 = get_input()
	move_and_slide(direction * speed)
	clamp_position()
	manage_terror(delta)
	manage_animation()
	manage_ghost()
	
	
func get_input() -> Vector2:
	var direction : = Vector2()
	
	moving = false
	
	if Input.is_action_pressed("movement_right"):
		moving = true
		direction.x = 1
	
		sprite.flip_h = false
	
	elif Input.is_action_pressed("movement_left"):
		moving = true
		direction.x = -1

		sprite.flip_h = true
		
	elif Input.is_action_pressed("movement_up"):
		moving = true
		direction.y = -1
			
	elif Input.is_action_pressed("movement_down"):
		moving = true
		direction.y = +1
	
	return direction
	
	
func manage_terror(delta : float) -> void:
	if moving:
		terror += .5
	elif terror > 0:
		terror -= .5
		
	terror = clamp(terror, 0, 100)

	if terror == 100:
		speed = ultra_scared_speed
	elif terror > 50 && terror < 100:
		speed = scared_speed
	else:
		speed = normal_speed
		
	emit_signal("terror_changed", terror)
		
		
func manage_animation() -> void:
	var new_anim : String = "idle"
	
	if moving:
		new_anim = "walk"
		if terror > 50:
			new_anim = "walk_scared"
		
	if !moving && terror > 0:
		new_anim = "recover"
		
	if anim != new_anim:
		sprite.play(new_anim)
		
	anim = new_anim
	

func clamp_position() -> void:
	position.y = clamp(position.y, 24, 480 - 60 - 48)
	
	
func manage_ghost() -> void:
	if !moving && !spawn_timer_started:
		spawn_timer.start()
		spawn_timer_started = true
	elif moving && spawn_timer_started:
		spawn_timer.stop()
		spawn_timer_started = false
		
		
func _on_Timer_timeout() -> void:
	emit_signal("spawn_timer_ended", position)
