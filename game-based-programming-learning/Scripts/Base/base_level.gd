extends Node2D
@onready var play = preload("res://Scenes/character/player/player_selfmade.tscn") #preload("res://Scenes/Test/Test_Player.tscn")
var player
func _ready() -> void:
	if get_tree().get_first_node_in_group("codelevel"):
		play = preload("res://Scenes/character/player/code_player.tscn")
	if get_tree().get_first_node_in_group("player")==null:
		print("yes")
		player = play.instantiate()
		add_child(player)
		print(player.get_groups())
		player.add_to_group("player")
		print(player.get_groups())
	Settings.current_scene = scene_file_path
	
	


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body == player:
		$Area2D/Timer.start(5)


func _on_area_2d_body_exited(body: Node2D) -> void:
	if body == player:
		$Area2D/Timer.stop()


func _on_timer_timeout() -> void:
	if player.has_method("_free_him"):
		player._free_him()
