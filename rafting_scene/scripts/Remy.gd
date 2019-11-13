extends Node2D
class_name PlayerMouse

export(int, 50, 150) var velocity_y = 70
export(int, 50, 150) var offset_y = 75

onready var sprite : AnimatedSprite = $AnimatedSprite as AnimatedSprite
onready var camera = get_node("../Camera2D")
onready var horizontal_movement_tween : Tween = $HorizontalMovementTween
onready var vertical_movement_tween : Tween= $VerticalMovementTween

var direction : = Vector2()

var tween_active : bool = false

func _ready() -> void:
	sprite.play("idle")


func _process(delta : float) -> void:
	camera.position.y = position.y - offset_y
	direction = get_input(delta)
	globals.rafting_speed = velocity_y
	
	
func movement(direction : Vector2) -> void:
	if tween_active:
		return
	
	if direction.x != 0:
		if (position.x < 50 && direction.x < 0) || (position.x > 430 && direction.x > 0):
			return
		horizontal_movement_tween.interpolate_property(self, "position:x",
	        position.x, position.x + 25 * direction.x, .3,
	        Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
		tween_active = true
		
		horizontal_movement_tween.start()
		
	elif direction.y != 0:
		if (offset_y <= 50 && direction.y < 0) || (offset_y > 150 && direction.y > 0):
			return
		vertical_movement_tween.interpolate_property(self, "offset_y",
        offset_y, offset_y + 25 * direction.y, .3,
        Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
		tween_active = true
		
		vertical_movement_tween.start()
	

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
	

func _on_HorizontalMovementTween_tween_all_completed() -> void:
	tween_active = false


func _on_VerticalMovementTween_tween_all_completed() -> void:
	tween_active = false


func _on_Area2D_area_entered(area: Area2D) -> void:
	print(area)
