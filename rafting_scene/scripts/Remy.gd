extends Node2D
class_name PlayerMouse

signal scene_timer_ended

export(int, 50, 150) var velocity_y = 70
export(int, 50, 150) var offset_y = 75

onready var sprite : AnimatedSprite = $AnimatedSprite as AnimatedSprite
onready var camera = get_node("../Camera2D")
onready var horizontal_movement_tween : Tween = $HorizontalMovementTween
onready var vertical_movement_tween : Tween= $VerticalMovementTween
onready var rotation_tween : Tween= $RotationTween
onready var blink_timer: Timer = $BlinkTimer

var direction : = Vector2()

var tween_active : bool = false
var blinking : bool = false
var is_on_scene_transition : bool  = false
var second_counter : float = 0


func _ready() -> void:
	sprite.play("idle")
	blink_timer.set_one_shot(true)
	blink_timer.set_wait_time(3)


func _on_HorizontalMovementTween_tween_all_completed() -> void:
	tween_active = false


func _on_VerticalMovementTween_tween_all_completed() -> void:
	tween_active = false


func _on_Area2D_area_entered(area: Area2D) -> void:
	if is_on_scene_transition:
		return
		
	init_scene_transition()
	
	blink_timer.start()
	blinking = true
	
	emit_signal("scene_timer_ended", false)
	
	
func _on_RaftingScene_countdown_timer_ended() -> void:
	if is_on_scene_transition:
		return
	
	init_scene_transition()
	
	emit_signal("scene_timer_ended", true)


func _process(delta : float) -> void:
	camera.position.y = position.y - offset_y
	globals.rafting_speed = velocity_y
	
	if !is_on_scene_transition:
		direction = get_input(delta)
		
	if blinking:
		var uniform_periodic = abs(cos(blink_timer.time_left * PI))
		sprite.get_material().set_shader_param("whitening", uniform_periodic)
	
	
func movement(direction : Vector2) -> void:
	if tween_active:
		return
	
	if direction.x != 0:
		if (position.x < 50 && direction.x < 0) || (position.x > 430 && direction.x > 0):
			return
			
		horizontal_movement_tween.interpolate_property(self, "position:x",
			position.x, position.x + 25 * direction.x, .3,
			Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
		rotation_tween.interpolate_property(self, "rotation_degrees",
			self.rotation_degrees, 15 * direction.x, .3,
			Tween.TRANS_SINE, Tween.EASE_IN_OUT)
			
		tween_active = true
		
		horizontal_movement_tween.start()
		rotation_tween.start()
		
	elif direction.y != 0:
		if (offset_y <= 50 && direction.y < 0) || (offset_y > 150 && direction.y > 0):
			return
			
		vertical_movement_tween.interpolate_property(self, "offset_y",
			offset_y, offset_y + 25 * direction.y, .3,
			Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
		rotation_tween.interpolate_property(self, "rotation_degrees",
			self.rotation_degrees, 0, .3,
			Tween.TRANS_SINE, Tween.EASE_IN_OUT)
			
		tween_active = true
		
		vertical_movement_tween.start()
		rotation_tween.start()
	

func get_input(delta : float) -> Vector2:
	var direction : = Vector2()

	if Input.is_action_just_pressed("movement_right"):
		direction.x = -1
		sprite.flip_h = false
		movement(direction)
		
	elif Input.is_action_just_pressed("movement_left"):
		direction.x = +1
		sprite.flip_h = true
		movement(direction)
		
	elif Input.is_action_just_pressed("movement_up"):
		velocity_y = min(velocity_y + 20, 150)
		direction.y = +1
		movement(direction)
		
	elif Input.is_action_just_pressed("movement_down"):
		velocity_y = max(velocity_y - 20, 50)
		direction.y = -1
		movement(direction)
	
	return direction
	
	
func init_scene_transition():
	is_on_scene_transition = true
	sprite.stop()
	