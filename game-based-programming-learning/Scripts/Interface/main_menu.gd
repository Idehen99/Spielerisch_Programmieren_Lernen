extends CanvasLayer

func _ready() -> void:
	pass
	#$Background.play("default")
	


func _on_play_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/Interface/game_files.tscn")


func _on_quit_button_pressed() -> void:
	get_tree().quit()
