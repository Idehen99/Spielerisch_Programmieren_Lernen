extends Node2D
@export var destination = "res://Scenes/level/level_1.tscn"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$mill.play("default")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		if $door:
			$door.play("open")
			await $door.animation_looped
			get_tree().change_scene_to_file(destination)
