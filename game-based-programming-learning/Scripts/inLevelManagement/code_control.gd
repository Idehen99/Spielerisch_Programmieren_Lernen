extends Node2D
class_name CodeControl

@export var player_path: NodePath
@onready var runner = $ProgrammRunner
@onready var builder = $ProgrammBuilder
@onready var editor = $CanvasLayer/CodeEditor
@onready var posi 
var player
var play
func _ready():
	if get_tree().get_first_node_in_group("player")!=null:
		player = get_tree().get_first_node_in_group("player")
		editor.visible = true
		runner.player = player
		posi = player.global_position
		play=player


func _on_play_pressed() -> void:
	posi = player.global_position
	$CanvasLayer/play.disabled = true
	$CanvasLayer/retry.disabled = false
	var program_data = builder.build_program(editor.code_container)
	runner.run_block_list(program_data)
	


func _on_retry_pressed() -> void:
	play.global_position = posi
	runner.wall_contact(false)
	$CanvasLayer/play.disabled = false
	$CanvasLayer/retry.disabled = true

func _on_back_to_level_pressed() -> void:
	if get_tree().get_first_node_in_group("changeArea"):
		var stuff = get_tree().get_first_node_in_group("changeArea")
		if get_tree().get_first_node_in_group("player")!=null:
			player = get_tree().get_first_node_in_group("player")
			player.position = stuff.position


func _on_delete_all_button_pressed() -> void:
	var dialog = ConfirmationDialog.new()
	dialog.title = "Bestätigung"
	dialog.dialog_text = "Willst du das wirklich löschen?"
	dialog.get_ok_button().text = "Ja"
	dialog.get_cancel_button().text = "Nein"
	add_child(dialog)
	dialog.popup_centered()
	dialog.confirmed.connect(_on_confirmed)

func _on_confirmed():
	print("Bestätigt!")
	for child in $CanvasLayer/CodeEditor/MarginContainer/ScrollContainer/codeContainer.get_children():
		child.queue_free()
