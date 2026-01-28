extends Control


func _on_female_pressed() -> void:
	Settings.Gender="Female"
	get_tree().change_scene_to_file("res://Scenes/level/level_1.tscn")


func _on_male_pressed() -> void:
	Settings.Gender="Male"
	get_tree().change_scene_to_file("res://Scenes/level/level_1.tscn")
