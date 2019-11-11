extends KinematicBody2D
class_name PlayerMouse

export(int, 50, 150) var velocity_y = 100
export(int, 50, 150) var offset_y = 75

onready var sprite : AnimatedSprite = $AnimatedSprite as AnimatedSprite
onready var camera = get_node("../Camera2D")
onready var horizontal_movement_tween : Tween = $HorizontalMovementTween
onready var vertical_movement_tween : Tween= $VerticalMovementTween

var direction : = Vector2()
var velocity : = Vector2()

var tween_active : bool = false

func _ready() -> void:
	sprite.play("idle")


func _process(delta : float) -> void:
	camera.position.y = position.y - offset_y
	direction = get_input(delta)
	

func _physics_process(delta : float) -> void:
	velocity.y = - velocity_y
	velocity = move_and_slide(velocity)
	
	
func movement(direction : Vector2):
	if tween_active:
		return
		
	if direction.x != 0:
		horizontal_movement_tween.interpolate_property(self, "position:x",
	        position.x, position.x + 25 * direction.x, .5,
	        Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
		tween_active = true
		
		horizontal_movement_tween.start()
		
	elif direction.y != 0:
		vertical_movement_tween.interpolate_property(self, "offset_y",
        offset_y, offset_y + 25 * direction.y, .5,
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
		velocity_y = min(velocity_y + 25, 150)
		direction.y = +1
		movement(direction)
		
	elif Input.is_action_just_pressed("movement_down"):
		velocity_y = max(velocity_y - 25, 50)
		direction.y = -1
		movement(direction)
	
	return direction
	

func _on_HorizontalMovementTween_tween_all_completed():
	tween_active = false


func _on_VerticalMovementTween_tween_all_completed():
	tween_active = false
