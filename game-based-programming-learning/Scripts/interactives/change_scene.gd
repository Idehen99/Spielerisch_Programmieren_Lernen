extends Area2D

@export var destination: String = "res://Scenes/level/level_1.tscn"
@export var new_position_for_player: Vector2 = Vector2(1,1)
@export var angeschaltet = true
@export var ab_wann = 0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if Settings.levelFinished != ab_wann and angeschaltet:
		monitoring = false
	else:
		monitoring = true

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		Settings._on_change_scene_spawn_position(new_position_for_player)
		get_tree().call_deferred("change_scene_to_file", destination)
		
		
