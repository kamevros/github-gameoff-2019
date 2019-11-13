extends Node

export(NodePath) var obstacles_node_path : NodePath
onready var obstacles_node = get_node(obstacles_node_path)
onready var swirl : PackedScene = preload("res://rafting_scene/scenes/Swirl.tscn")
onready var branch : PackedScene = preload("res://rafting_scene/scenes/Branch.tscn")
onready var rock : PackedScene = preload("res://rafting_scene/scenes/Rock.tscn")
onready var rock1 : PackedScene = preload("res://rafting_scene/scenes/Rock1.tscn")
onready var rock2 : PackedScene = preload("res://rafting_scene/scenes/Rock2.tscn")

onready var obstacles = [swirl, branch, rock, rock1, rock2]
var rng : = RandomNumberGenerator.new()


func _ready() -> void:
    rng.randomize()
	
	
func _on_SpawnTimer_timeout() -> void:
	var index : int = rng.randi_range (0, get_child_count() - 1)
	var obstacle : int = rng.randi_range (0, obstacles.size() - 1)

	var instance = obstacles[obstacle].instance()
	instance.set_global_position(get_child(index).get_position())
	obstacles_node.add_child(instance)
