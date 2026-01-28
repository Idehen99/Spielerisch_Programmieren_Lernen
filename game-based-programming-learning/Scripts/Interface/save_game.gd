extends VBoxContainer


func _on_continue_pressed() -> void:
	$".".visible = false


func _on_save_n_continue_pressed() -> void:
	var level = get_tree().get_first_node_in_group("level").scene_file_path
	var player_pos = get_tree().get_first_node_in_group("player").global_position
	var gender = Settings.Gender
	var  all_data = {
		"actual_scene":level,
		"player_pos": player_pos,
		"inventory": "inventory",
		"new": false,
		"gender":gender
	}
	
	Savefile.save_all(Settings.Spielstand, all_data)
	$".".visible = false


func _on_save_n_exit_pressed() -> void:
	var level = get_tree().get_first_node_in_group("level").scene_file_path
	var player_pos = get_tree().get_first_node_in_group("player").global_position
	var gender = Settings.Gender
	var all_data = {
		"actual_scene":level,
		"player_pos": player_pos ,
		"inventory": "inventory",
		"new": false,
		"gender":gender
	}
	Savefile.save_all(Settings.Spielstand ,all_data)
	get_tree().change_scene_to_file("res://Scenes/Interface/main_menu.tscn")


func _on_menu_pressed() -> void:
	$".".visible = true
