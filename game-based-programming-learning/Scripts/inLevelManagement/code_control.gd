extends Node
class_name CodeControl

@export var player_path: NodePath
@onready var runner = $ProgrammRunner
@onready var builder = $ProgrammBuilder
@onready var editor = $CodeEditor
@onready var posi 
var play
func _ready():
	if get_tree().get_first_node_in_group("player")!=null:
		var player = get_tree().get_first_node_in_group("player")
		editor.visible = true
		runner.player = player
		posi = player.global_position
		play=player


func _on_play_pressed() -> void:
	$play.disabled = true
	var program_data = builder.build_program(editor.code_container)
	runner.run_block_list(program_data)
	


func _on_retry_pressed() -> void:
	play.global_position = posi
	$play.disabled = false
