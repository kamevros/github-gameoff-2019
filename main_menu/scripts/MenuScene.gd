extends Node

var climbing_scene = "res://climbing_scene/scenes/ClimbingScene.tscn"
var rafting_scene = "res://rafting_scene/scenes/RaftingScene.tscn"
var hiking_scene = "res://hiking_scene/scenes/HikingScene.tscn"
var option_scene = "res://option_scene/scenes/OptionScene.tscn"
var quit_scene = "res://quit_scene/scenes/QuitScene.tscn"

export(int, 0, 4) var selector : int = 1

onready var beatrix_sprite : AnimatedSprite = $Characters/Beatrix as AnimatedSprite
onready var gustaf_sprite : AnimatedSprite = $Characters/Gustaf as AnimatedSprite
onready var remy_sprite : AnimatedSprite = $Characters/Remy as AnimatedSprite
onready var tent_sprite : AnimatedSprite = $Background/Tent as AnimatedSprite
onready var sign_sprite : AnimatedSprite = $Background/Sign as AnimatedSprite

onready var selector_array = [sign_sprite, remy_sprite, beatrix_sprite, gustaf_sprite, tent_sprite]
onready var scene_array = [quit_scene, rafting_scene, hiking_scene, climbing_scene, option_scene]
onready var text_array = [null, "remy_begin", "beatrix_begin", "gustaf_begin", null]

var second_counter : float = 0

func _ready() -> void:
	for sprite in selector_array:
		sprite.animation = "default"
		if sprite.get_child_count() > 0:
			sprite.get_child(0).set_current_animation("idle")

func _process(delta : float) -> void:
	second_counter += delta
	var uniform_periodic = abs(cos(second_counter*3))

	selector_array[selector].material.set_shader_param("alpha", uniform_periodic)
	
	for sprite in selector_array:

		if sprite == selector_array[selector]:
			sprite.animation = "idle"
			if sprite.get_child_count() > 0:
				if sprite.get_child(0).get_assigned_animation() != "one_shot":
					sprite.get_child(0).set_current_animation("one_shot")
					sprite.get_child(2).show()
			continue
		sprite.material.set_shader_param("alpha", 0)
		sprite.animation = "default"
		if sprite.get_child_count() > 0:
			if sprite.get_child(0).get_current_animation() != "idle":
				sprite.get_child(0).set_current_animation("idle")
				sprite.get_child(2).hide()
	
	if Input.is_action_pressed("ui_accept"):
		if text_array[selector]:
			globals.string_to_render = text_array[selector]
		scene_manager.change_scene(scene_array[selector])
		
	if Input.is_action_just_pressed("movement_left"):
		selector -= 1
		if selector < 0:
			selector = selector_array.size() - 1
		
	elif Input.is_action_just_pressed("movement_right"):
		selector += 1
		if selector > selector_array.size() - 1:
			selector = 0
			