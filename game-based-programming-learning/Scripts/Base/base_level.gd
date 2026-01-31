extends Node2D
@onready var play = preload("res://Scenes/character/player/player.tscn")
func _ready() -> void:
	if get_tree().get_first_node_in_group("player")==null:
		print("yes")
		var player = play.instantiate()
		add_child(player)
		print(player.get_groups())
		player.add_to_group("player")
		print(player.get_groups())
	
	
