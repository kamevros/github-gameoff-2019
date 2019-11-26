extends Node2D

signal countdown_timer_ended

export(int, 5, 180, 5) var seconds_to_play : int = 30
export(float, 5, 20, 1) var difficulty_increase_timer : float = 10

onready var next_increment_difficulty : float = difficulty_increase_timer
onready var game_timer : Timer = $GameTimer

var time_start : int = 0
var time_now : int = 0


func _ready() -> void:
	$MusicPlayer.play()
	game_timer.wait_time = seconds_to_play
	game_timer.start()
	set_process(true)
	

func _process(delta: float) -> void:
	var remaining : int = int(game_timer.time_left)
	
	if remaining <= 0:
		globals.remy_victory = true
		emit_signal("countdown_timer_ended")
		set_process(false)
		$Canvas/CountdownTimerLabel.text = 0 as String
		return
		
	$Canvas/CountdownTimerLabel.text = remaining as String
	
	next_increment_difficulty -= delta
	
	if next_increment_difficulty < 0:
		$SpawnTimer.wait_time -= 0.25
		increase_difficulty()
		next_increment_difficulty = difficulty_increase_timer
		
		
func _on_Area2D_body_entered(body: PhysicsBody2D) -> void:
	if body is PlayerRabbit:
		print("sadad")
		
		
func increase_difficulty() -> void:
	$Canvas/DifficultyLabel.show()
	yield(get_tree().create_timer(2.0), "timeout")
	$Canvas/DifficultyLabel.hide()



