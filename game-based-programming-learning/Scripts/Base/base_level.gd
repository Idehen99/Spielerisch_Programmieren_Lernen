extends Node2D
@onready var play = preload("res://Scenes/character/player/player_selfmade.tscn") 
@export var levelsFinished = 1

var player
func _ready() -> void:
	if get_tree().get_first_node_in_group("codelevel"):
		play = preload("res://Scenes/character/player/code_player.tscn")
	if get_tree().get_first_node_in_group("codelevel"):
		play = preload("res://Scenes/character/player/code_player_premium.tscn")
	if get_tree().get_first_node_in_group("player")==null:
		player = play.instantiate()
		$CameraArea2D._worked(player.get_node("Camera2D"))
		add_child(player)
		player.add_to_group("player")
	Settings.current_scene = scene_file_path
	fire()
	print(Settings.levelFinished)


func fire():
	if get_tree().get_first_node_in_group("fire"):
		if Settings.fire:
			var Kamin = get_tree().get_first_node_in_group("fire")
			Kamin.visible = true
			get_tree().get_first_node_in_group("fireAnimation").play("default")
			_finished_level()


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body == player:
		var groupies = get_tree().get_nodes_in_group("objectBool")
		for groupie in groupies:
			groupie.change_sensor_state(true)
		$Area2D/Timer.start(5)


func _on_area_2d_body_exited(body: Node2D) -> void:
	if body == player:
		$Area2D/Timer.stop()
		var groupies = get_tree().get_nodes_in_group("objectBool")
		for groupie in groupies:
			groupie.change_sensor_state(false)


func _on_timer_timeout() -> void:
	if player.has_method("_free_him"):
		player._free_him()
	finished_level(levelsFinished)


func _finished_level():
	finished_level(levelsFinished)
	

func finished_level(levelGotFinished):
	if Settings.levelFinished < levelGotFinished:
		Settings.levelFinished = levelGotFinished
	print(levelsFinished, levelGotFinished, Settings.levelFinished)
