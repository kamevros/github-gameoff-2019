extends Node

var climbing_scene = "res://climbing_scene/scenes/ClimbingScene.tscn"
var rafting_scene = "res://rafting_scene/scenes/RaftingScene.tscn"
var hiking_scene = "res://hiking_scene/scenes/HikingScene.tscn"
var option_scene = "res://option_scene/scenes/OptionScene.tscn"
var quit_scene = "res://quit_scene/scenes/QuitScene.tscn"

onready var day = preload("res://main_menu/scenes/Day.tres")

export(int, 0, 4) var selector : int = 0

onready var beatrix_sprite : AnimatedSprite = $Characters/Beatrix as AnimatedSprite
onready var gustaf_sprite : AnimatedSprite = $Characters/Gustaf as AnimatedSprite
onready var remy_sprite : AnimatedSprite = $Characters/Remy as AnimatedSprite
onready var tent_sprite : AnimatedSprite = $Background/Tent as AnimatedSprite
onready var sign_sprite : AnimatedSprite = $Background/Sign as AnimatedSprite

onready var selector_dict = {
	"remy" : {
		"sprite" : remy_sprite,
		"scene" : rafting_scene,
		"text" : "remy_begin"
	},
	"beatrix" : {
		"sprite" : beatrix_sprite,
		"scene" : hiking_scene,
		"text" : "beatrix_begin"
	},
	"gustaf" : {
		"sprite" : gustaf_sprite,
		"scene" : climbing_scene,
		"text" : "gustaf_begin"
	},
	"sign" : {
		"sprite" : sign_sprite,
		"scene" : quit_scene,
		"text" : null
	}
}

var second_counter : float = 0
var victory : bool = false

func _ready() -> void:
	disable_quit_on_web_build()
	hide_completed_minigame()
	check_victory()
	
	if selector_dict.size() <= 0:
		return
		
	for obj in selector_dict:
		var sprite = selector_dict[obj].sprite
		sprite.animation = "default"
		if sprite.get_child_count() > 0:
			sprite.get_child(0).set_current_animation("idle")
			
			
func _process(delta : float) -> void:
	if selector_dict.size() <= 0:
		return
		
	second_counter += delta
	var uniform_periodic = abs(cos(second_counter * 3))
	
	var selector_keys = selector_dict.keys()
	var selected = selector_keys[selector]
	selector_dict[selected].sprite.material.set_shader_param("alpha", uniform_periodic)
	
	for obj in selector_dict:
		var sprite = selector_dict[obj].sprite
		
		if obj == selected:
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
		if selector_dict[selected].text:
			globals.string_to_render = selector_dict[selected].text
		scene_manager.change_scene(selector_dict[selected].scene)
		
	if Input.is_action_just_pressed("movement_left"):
		selector -= 1
		if selector < 0:
			selector = selector_keys.size() - 1
		
	elif Input.is_action_just_pressed("movement_right"):
		selector += 1
		if selector > selector_keys.size() - 1:
			selector = 0
			
			
func disable_quit_on_web_build() -> void:
	if OS.has_feature('JavaScript') || OS.has_feature('HTML5'):
		selector_dict.erase("sign")
		
		
func hide_completed_minigame() -> void:
	if globals.remy_victory:
		selector_dict["remy"].sprite.hide()
		selector_dict.erase("remy")
	if globals.beatrix_victory:
		selector_dict["beatrix"].sprite.hide()
		selector_dict.erase("beatrix")
	if globals.gustaf_victory:
		selector_dict["gustaf"].sprite.hide()
		selector_dict.erase("gustaf")
		

func check_victory():
	if globals.remy_victory && globals.beatrix_victory && globals.gustaf_victory:
		$Background/End.show()
		$Background/Stars.hide()
		$Background/Gradient/TextureRect.texture = day
		$Characters/Fire.play("off")
		$Background/Tent.play("off")
		