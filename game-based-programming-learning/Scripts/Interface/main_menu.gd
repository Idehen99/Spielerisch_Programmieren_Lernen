extends CanvasLayer

func _ready() -> void:
	$Background.play("default")
	


func _on_play_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/Interface/save_game.tscn")


func _on_quit_button_pressed() -> void:
	get_tree().quit()
