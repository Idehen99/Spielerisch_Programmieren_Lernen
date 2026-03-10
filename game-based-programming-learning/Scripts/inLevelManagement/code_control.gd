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
	$CanvasLayer/play.disabled = false
	$CanvasLayer/retry.disabled = true

func _on_back_to_level_pressed() -> void:
	if get_tree().get_first_node_in_group("changeArea"):
		var stuff = get_tree().get_first_node_in_group("changeArea")
		if get_tree().get_first_node_in_group("player")!=null:
			player = get_tree().get_first_node_in_group("player")
			player.position = stuff.position
