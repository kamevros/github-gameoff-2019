extends Node

signal countdown_timer_ended

export(int, 10, 180, 5) var seconds_to_play : int = 90
export(float, 5, 20, 1) var difficulty_increase_timer : float = 10

onready var next_increment_difficulty = difficulty_increase_timer

var time_start : int = 0
var time_now : int = 0


func _ready() -> void:
	$MusicPlayer.play()
	time_start = OS.get_unix_time()
	set_process(true)
	

func _process(delta: float) -> void:
	time_now = OS.get_unix_time()
	var elapsed : int = time_now - time_start
	var seconds : int = elapsed % 60
	var remaining : int = seconds_to_play - seconds
	
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
		
		
func increase_difficulty() -> void:
	$Canvas/DifficultyLabel.show()
	yield(get_tree().create_timer(2.0), "timeout")
	$Canvas/DifficultyLabel.hide()
