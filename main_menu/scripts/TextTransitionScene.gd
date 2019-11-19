extends CanvasLayer

onready var text : Label = $Text

signal transition_done

func _ready():
	pause_mode = Node.PAUSE_MODE_PROCESS
	set_process(false)
	get_tree().paused = true
	if globals.string_to_render:
		text.text = globals[globals.string_to_render]
		set_process(true)
	else:
		get_tree().paused = false
		queue_free()
		
func _process(delta):
	if Input.is_action_just_pressed("ui_accept"):
		yield(get_tree().create_timer(0.5), "timeout")
		globals.string_to_render = null
		get_tree().paused = false
		queue_free()

