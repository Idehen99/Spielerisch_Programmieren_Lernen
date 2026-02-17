extends Area2D

@export var destination = "res://Scenes/level/level_1.tscn"
@export var new_position_for_player: Vector2 = Vector2(1,1)


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		Settings._on_change_scene_spawn_position(new_position_for_player)
		get_tree().call_deferred("change_scene_to_file", destination)
		
		
