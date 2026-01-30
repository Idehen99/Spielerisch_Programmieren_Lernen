extends CanvasLayer
@onready var sure = $Sure
@onready var label = $Sure/Label
@onready var files = $Files

var which = 0





func _on_first_pressed() -> void:
	Settings.Spielstand = 1
	if Savefile.load_variable(1,"new","n") == true:
		Settings.saveData = Savefile.load_all(1)
		Settings.new = true
		get_tree().change_scene_to_file("res://Scenes/Interface/gender_selection.tscn")
	else:
		Settings.saveData = Savefile.load_all(1)
		var scene = Savefile.load_variable(1,"actual_scene", "n")
		get_tree().change_scene_to_file(scene)


func _on_delete_1_pressed() -> void:
	which = 1
	sure.visible = true
	label.text = "Bist du dir sicher, dass du Spielstand 1 Löschen möchtest"
	files.visible = false


func _on_second_pressed() -> void:
	Settings.Spielstand = 2
	if Savefile.load_variable(2,"new","n") == true:
		Settings.saveData = Savefile.load_all(2)
		Settings.new = true
		get_tree().change_scene_to_file("res://Scenes/Interface/gender_selection.tscn")
	else:
		Settings.saveData = Savefile.load_all(2)
		var scene = Savefile.load_variable(2,"actual_scene", "n")
		get_tree().change_scene_to_file(scene)

func _on_delete_2_pressed() -> void:
	which = 2
	sure.visible = true
	label.text = "Bist du dir sicher,\ndass du Spielstand 2\nLöschen möchtest"
	files.visible = false


func _on_yes_pressed() -> void:
	Savefile.save_all(which,{
		"new": true,
		"player_pos": Vector2(376.0,476.0)
	})
	files.visible = true
	sure.visible = false


func _on_no_pressed() -> void:
	which = 0
	files.visible = true
	sure.visible = false
