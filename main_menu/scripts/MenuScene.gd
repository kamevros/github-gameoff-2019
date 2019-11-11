extends Node

var climbing_scene = "res://climbing_scene/scenes/ClimbingScene.tscn"
var rafting_scene = "res://rafting_scene/scenes/RaftingScene.tscn"
var hiking_scene = "res://hiking_scene/scenes/HikingScene.tscn"

export(int, 0, 2) var selector : int = 0

onready var beatrix_sprite : AnimatedSprite = $CanvasLayer/Characters/Beatrix as AnimatedSprite
onready var gustaf_sprite : AnimatedSprite = $CanvasLayer/Characters/Gustaf as AnimatedSprite
onready var remy_sprite : AnimatedSprite = $CanvasLayer/Characters/Remy as AnimatedSprite
onready var arrow : Sprite = $CanvasLayer/Characters/Arrow as Sprite
onready var selector_array = [remy_sprite, beatrix_sprite, gustaf_sprite]
onready var scene_array = [rafting_scene, hiking_scene, climbing_scene]

var second_counter : float = 0

func _ready() -> void:
	for sprite in selector_array:
		sprite.animation = "default"

func _process(delta : float) -> void:
	second_counter += delta
	var uniform_periodic = abs(cos(second_counter*3))

	selector_array[selector].material.set_shader_param("alpha", uniform_periodic)
	
	for sprite in selector_array:
		if sprite == selector_array[selector]:
			sprite.animation = "idle"
			arrow.position.y = sprite.position.y - 50
			arrow.position.x = sprite.position.x
			continue
		sprite.material.set_shader_param("alpha", 0)
		sprite.animation = "default"
	
	if Input.is_action_pressed("ui_accept"):
		scene_manager.change_scene(scene_array[selector])
		
	if Input.is_action_just_pressed("movement_left"):
		selector -= 1
		if selector < 0:
			selector = selector_array.size() - 1
		
	elif Input.is_action_just_pressed("movement_right"):
		selector += 1
		if selector > selector_array.size() - 1:
			selector = 0