extends Node

var rafting_speed : int = 50

var climbing_scene : String = "res://climbing_scene/scenes/ClimbingScene.tscn"
var rafting_scene : String = "res://rafting_scene/scenes/RaftingScene.tscn"
var hiking_scene : String = "res://hiking_scene/scenes/HikingScene.tscn"
var option_scene : String = "res://option_scene/scenes/OptionScene.tscn"
var quit_scene : String = "res://quit_scene/scenes/QuitScene.tscn"
var menu_scene : String = "res://main_menu/scenes/MenuScene.tscn"
var game_over_scene : String = "res://game_over_scene/scenes/GameOverScene.tscn"
var transition_scene : String = "res://main_menu/scenes/TextTransitionScene.tscn"

var remy_victory : bool = false
var gustaf_victory : bool = false
var beatrix_victory : bool = false

var string_to_render = null

var gustaf_begin : String = """
Gustaf fears heights. Quite unusual for an ibex cub, as their life goes upwards. 
Help him through this first ascent and one day he will climb on his own.
"""

var gustaf_end : String = """
Climbing his first mountain was not easy for Gustaf, but all it took was the courage to fail and someone to help him try again.
"""

var remy_begin : String = """
Remy could not believe how fast the river was flowing. 
The placid stillness of his childhood home fresh in his memory, he is now facing rapidly changing waters. 
Good you are here to see him through.
"""

var remy_end : String = """
That was quite the ride for Remy! 
Hard to pass the rapids unscathed, thankfully the power of his youth and a friendly hand helped him through.
"""

var beatrix_begin : String = """
Beatrix does not remember a time of such uncertainty. 
Even as a teen she always moved ahead fearing nothing but standing still. 
Lost In the dark of the Old Forest she cannot see the path forward, a friendly push will surely help.
"""

var beatrix_end : String = """
Age made Beatrix cautious and doubt led to fear, luckily she had a good friend to help her out of the woods.
"""

func _process(delta: float) -> void:
	
	if Input.is_action_pressed("ui_page_down"):
		remy_victory = true 
		gustaf_victory = true 
		beatrix_victory = true
