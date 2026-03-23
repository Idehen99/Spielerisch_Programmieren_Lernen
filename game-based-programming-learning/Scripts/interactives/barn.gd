extends Node2D
@export var destination: String = "res://Scenes/level/level_1.tscn"
@export var color = "brown"
@export var new_position_for_player: Vector2 = Vector2(1,1)
@export var levelsFinished = 0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	match color:
		"red":
			$wall.play("red")
		"brown":
			$wall.play("brown")
		"pink":
			$wall.play("pink")
	if Settings.levelFinished >= levelsFinished:
		$Area2D.monitoring = true
	else:
		$Area2D.monitoring = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		if $door:
			$door.play("open")
			await $door.animation_looped
			Settings._on_change_scene_spawn_position(new_position_for_player)
			get_tree().call_deferred("change_scene_to_file", destination)
