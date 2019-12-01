extends KinematicBody2D
class_name PlayerRabbit

signal scene_timer_ended

export(int, 50, 500) var speed : int = 100

onready var normal_speed : int = speed
onready var scared_speed : int = speed / 2
onready var ultra_scared_speed : int = speed / 3
onready var sprite : AnimatedSprite = $AnimatedSprite
onready var spawn_timer : Timer = $Timer
onready var blink_timer: Timer = $BlinkTimer

var anim : String = "idle"

var direction : = Vector2()
var velocity : = Vector2()

var moving : bool = false
var terror : float = 0
var spawn_timer_started = false
var is_on_scene_transition : bool  = false
var second_counter : float = 0
var blinking : bool = false

signal terror_changed
signal spawn_timer_ended


func _ready() -> void:
	blink_timer.set_one_shot(true)
	blink_timer.set_wait_time(3)

func _process(delta: float) -> void:
	var direction : Vector2 = get_input()
	
	if blinking:
		var uniform_periodic = abs(cos(blink_timer.time_left * PI))
		sprite.get_material().set_shader_param("whitening", uniform_periodic)
		
	if is_on_scene_transition:
		return
	
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
		terror += .3
	elif terror > 0:
		terror -= .5
		
	terror = clamp(terror, 0, 100)

	if terror == 100:
		_on_gameover()
	elif terror > 50 && terror < 100:
		speed = scared_speed
		if !$Heartbeat.playing:
			$Heartbeat.play()
	else:
		speed = normal_speed
		
	if terror == 0:
		_on_Timer_timeout()
		
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


func _on_gameover() -> void:
	if is_on_scene_transition:
		return
		
	init_scene_transition()
	
	blink_timer.start()
	blinking = true
	
	emit_signal("scene_timer_ended", false)
	
func init_scene_transition():
	is_on_scene_transition = true
	sprite.stop()


func _on_HikingScene_countdown_timer_ended() -> void:
	if is_on_scene_transition:
		return
	
	init_scene_transition()
	
	emit_signal("scene_timer_ended", true)
